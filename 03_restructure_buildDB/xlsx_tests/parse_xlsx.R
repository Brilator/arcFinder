
############################################################
### Script to read metadata from an isa.investigation.xlsx
############################################################

## rough idea: 

# 0. Takes two arguments as CLI input: <ARC id> and <isa.investigation.xlsx>
# 1. Check whether its an investigation sheet or loop over sheets
# 2. focus on investigation only
# 3. subset into investigation sections
# 4. Store JSON-like as (nested) lists
#   - column 1 = keys
#   - column(s) 2:n = values as a list
# 5. put out as RData for further processing


########################
### Setup
########################

### If package "readxl" is not installed, install it.
if(!require("readxl", quietly = TRUE)){install.packages("readxl")}

### load the package
library(readxl)


########################
### Inputs
########################

args = commandArgs(trailingOnly=TRUE)

# test if arguments are supplied: if not, return an error
if (length(args)!=2) {
  
  stop("<ARC id> and <isa.investigation.xlsx> must be supplied as arguments", call.=FALSE)
  
  } else if (length(args)==2) {
  
  # default output file
  isa_inv_wb <- args[2] 
  print(paste("Reading file", isa_inv_wb))
  arc_id <- args[1]
  print(paste0("Storing outputs in: ", arc_id, ".Rdata"))
}

########################
### read data from excel
########################

### loop over sheets of workbook
for(sheet in excel_sheets(isa_inv_wb)){
  
  ### read sheet
  current_sheet <- as.data.frame(read_xlsx(isa_inv_wb, col_names = F, sheet = sheet, .name_repair = "minimal"))
  
  ### Simple sanity check for ISA investigation format
  
  if(current_sheet[1, 1] == "ONTOLOGY SOURCE REFERENCE" & current_sheet[2, 1] == "Term Source Name"){
    
    print(paste("Reading from excel sheet", sheet))
    invdata <- current_sheet
    
  }else{
    print(paste("Excel sheet", sheet, "is not in ISA investigation format"))
    invdata <- NULL
  }
  
}

### Stop if no proper ISA sheet detected
if(is.null(invdata)){stop(simpleError("No valid ISA ingestigation sheet detected"))}


########################
### wrangle / extract only relevant data
########################


### subset to investigation only (excluding study, assay layers)
investigation_data <- invdata[grepl("^investigation",  invdata[, 1], ignore.case = T), ]

### first column as row names
rownames(investigation_data) <- investigation_data[,1]
investigation_data2 <- investigation_data[,-1]

### extract investigation subsections (some redundancy with above)
inv_sections <- which(grepl("^INVESTIGATION",  row.names(investigation_data2), ignore.case = F))

investigation_list <- list()
for(i in 1:length(inv_sections))
{
  
  if(i == length(inv_sections))
    {
    section_range <- (inv_sections[i] + 1):nrow(investigation_data2)
    }else{
    section_range <- (inv_sections[i] + 1):(inv_sections[i+1] - 1)  
    }
  
  current_section <- investigation_data2[section_range, ]
  
  ### transpose / pivot data to transform into list
  current_section_transposed <- as.data.frame(t(current_section))
  
  ### extract current section name
  current_section_name <- row.names(investigation_data2)[inv_sections[i]]
  
  ### transform to named list, omitting NAs
  investigation_list[[current_section_name]] <- lapply(current_section_transposed, function(v){v[!is.na(v)]})
  
}

########################
### output to .RData
########################

save(investigation_list, isa_inv_wb, arc_id, file = paste0(arc_id, ".RData"))

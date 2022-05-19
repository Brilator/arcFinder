############################################################
### Script to pull together output of previous scripts
############################################################

if(!require("DBI", quietly = TRUE)){install.packages("DBI")}
library(DBI)

### for loop over available RData dumps from 03_parse_isaInvxlsx.R

all_arcs <- list()

for(i in dir(".tmp03_rdata_dumps/", full.names = T, pattern = ".RData"))
{
  ### load the data
  load(i)
  
  ### store in named list
  
  all_arcs[[arc_id]] <- investigation_list
    
}

### row-bind the second-level (i.e. INVESTIGATION "sections") of the lists, respectively

# library(purrr)
# all_arcs_db <- lapply(transpose(all_arcs), function(x) do.call(rbind, x))

all_arcs_db <- do.call(Map, c(f = rbind, all_arcs))

### read the arc_list (translating the ARC id to the ARC path) produced by 02_read_from_gitlab.sh
### and append to above list

arc_list <- read.table(".tmp02_investigations/arc_list.tsv", sep = "\t", header = T)
colnames(arc_list)[1] <- "arc_id"

# all_arcs_db[["arc_list"]] <- arc_list

### store the output as RData
 
save(all_arcs, all_arcs_db, arc_list, file = ".tmp03_allARCs.RData")

### Write into an SQLite DB file

mydb <- dbConnect(RSQLite::SQLite(), "tmp03_allARCs.sqlite")

for(i in names(all_arcs_db))
{
  dbWriteTable(mydb, i, all_arcs_db[[i]], overwrite = T)
}

dbWriteTable(mydb, "ARC list", arc_list, overwrite = T)

dbListTables(mydb)
dbDisconnect(mydb)







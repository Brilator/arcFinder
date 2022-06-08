---
title: "ARC-Finder &ndash; A simple, locally-deployed tool to find your peer's research data"
author: [Dominik Brilhaus, <https://orcid.org/0000-0001-9021-3197>]
date: "2022-06-09"
keywords: [Metadata, ARC, DataPLANT]
subtitle: "Projektmodul (Modul 9) des Zertifikatskurs FDM (15.07) 2021 / 2022"
lang: "en"
toc: true
toc-own-page: true
titlepage: true
titlepage-color: "2D3E50"
titlepage-text-color: "FFC000"
titlepage-rule-color: "FFC000"
titlepage-rule-height: 2
header-includes:
- \usepackage{longtable, array, booktabs}
...

<!-- quickfix: For some weird reason the latex packages now have to be loaded first, when using a latex table with the eisvogel template. -->
<!-- used to work just fine without yesterday....  -->
<!-- pandoc template from: https://github.com/Wandmalfarbe/pandoc-latex-template -->
<!-- pandoc project.md -o project.pdf --from markdown --template eisvogel --listings -->

# Introduction

## Motivation

Research is a highly collaborative endeavor that builds on the synergistic interaction between different stakeholders enabled by efficient knowledge exchange. Gaining a prompt overview of the ongoing research efforts &ndash; both pre- and post-publication &ndash; is oftentimes hindered for social, legal or technical reasons. This often holds true even between parties of spatially closest and well trusted surroundings of a collaborative consortium such as the Cluster of Excellence on Plant Sciences (CEPLAS[^CEPLAS]). The key to enable discussion on and exchange of research data is *findability*, the first layer of the FAIR principles[^go-fair] of data stewardship (Wilkinson *et al.*, 2016[^wilkinson2016]). The project presented here aims to address this layer, by making CEPLAS research easily findable and visible amongst CEPLAS researchers and showcase the beauty and ease of data sharing to spike fruitful collaborations with peers.

## DataPLANT and the Annotated Research Context

Research data management (RDM) within CEPLAS is closely aligned with DataPLANT[^DataPLANT], the NFDI[^NFDI] consortium for plant sciences. At the heart of DataPLANT's RDM strategy lies the Annotated Research Context (ARC[^ARC]), a directory structure that packages research data together with associated metadata and computational workflows into self-sustained research objects. Annotation of research data in the ARC is based on the metadata schema ISA[^ISA] (for investigation &ndash; study &ndash; assay). Serialized in spread sheet format as *ISA-tab* this enables intuitive, flexible and yet structured and conclusive metadata annotation of the versatile data types produced in plant sciences. ARCs are git[^git] repositories that can be shared via DataPLANT's DataHUB[^DataHUB], a customized GitLab[^GitLab] instance with a federated authentication interface to allow controlled access across institute borders.  
Although the ARC environment is continuously being developed, the choice of these key technical pillars are set: (a) ARC as the structure, (b) ISA as the metadata language, (c) git as version control logic and (d) gitlab for ARC collaboration and user management. This allows to leverage the ARC environment and develop (intermediate) solutions for data findability, knowing that time and efforts are well-invested, since both (meta)data ingest into as well as secondary outputs dependent on the ARC will be adoptable and migratable in the future.  
While (contents of the) ARCs can be searched via standard GitLab-implemented mechanisms within the DataHUB or via standard routines on a user's system where the ARCs are locally cloned and stored, a structured and user-friendly search interface tailored to metadata stored in multiple ARCs is currently unavailable. With the ARC-Finder presented here, I seek to close this gap.

# Approach

## The ARC-Finder workflow

The ARC-Finder employs three concerted, but independent modules of metadata retrieval, restructure, and representation (Fig. 1).

![ARC-Finder Workflow. Depending wether the user provided a gitlab personal access token (PAT). the ARC-Finder retrieves publicly (1a) or publicly and privately (1b) accessible metadata from the DataHUB and stores it in a local data dump. The metadata is re-structured into a searchable database (2) and fed into the ARC-Finder GUI (3, details see Fig. 2) as well as provided as an SQLite database (DB) (4).](slides/2022-06-10_arcFinder_slides_brilhaus/2022-06-10_arcFinder_slides_brilhaus.001.png)


Depending on user-choice and gitlab personal access token (PAT) either publicly available (1a) or public plus privately shared (1b) ARCs are read and stored in a local data dump (see also user instructions in [README.md](#readmemd)).

From the ISA investigation workbooks (`isa.investigation.xlsx`) stored at the roots of every ARC. The CEPLAS-ARC-Finder selectively retrieves, downloads and dumps the metadata locally on the user's machine. The CEPLAS-ARC-Finder then restructures the metadata into a simple spreadsheet-based database. From the database the investigation data is finally read and represented by a user interface that enables finding the data available to the individual user.

## The ARC-Finder GUI

![ARC-Finder GUI.](slides/2022-06-10_arcFinder_slides_brilhaus/2022-06-10_arcFinder_slides_brilhaus.002.png)

## SQLite database as alternative output

## Data safety

This project focuses on metadata at the highest project and least sensitive (i.e. ISA's "investigation") level to minimize user input or possible discomfort with data sharing
- outsourced to DataHUB

Here, access to the ARCs can be controlled to share them publicly or with invited collaborators. 

## Technical back-end

The technical back-end of the ARC-Finder is a combination of shell and R scripts and leveraging on the GitLab API (version 4). The idea was to rely on as few code environments as possible. The actual code work is attached in the supplemental materials (see [scripts](#scripts)) and available online (see [availability](#availability)). Software dependencies are listed in the supplemental materials (see [dependencies](#dependencies)).

# Discussion

- The arcFinder provides a comparably easy approach
- Can immediately be used
  - I can add my ARC to the DataHUB and have it directly listed by the arcFinder

- One of the major hurdles in advocating FAIR data stewardship to the users is the continuously changing plethora of platforms, tools and schema.
- Integrable with future developments to avoid user friction

- Extensibility (within DataPLANT: beauty of standards )
  - Designed on purpose limited. User.
  - Show-case how use of standards can boost sustainable research data management.
  - Vehicle for communication
  - While most tools in DataPLANT are based on other programming languages…

- SQL Alternative

## Caveats and places for future improvements

### isa.investigation.xlsx

- read from isa.json rather than isa.investigation.xlsx
- Rationale: yet another detour / dependency to produce isa.json
- direct user-input to isa.investigation.xlsx can be read immediately
- xlsx can become big and needs to be dumped
- json could be read on-the-fly

### group-associated ARCs

- are currently excluded

### branches

- reading only from default git branch `main` (not e.g. master or others)

### efficiency

- tool dumps, pulls freshly every time it is called
  - nothing memorized and updated
  - by design sqlite db is always overwritten -> data could be appended
- selectivity
  - not all ARCs, but just selection (e.g. group)
  - error-prone: non-clean ARCs

### Scalability

- CI / CD, public access / deployment

\pagebreak

# Supplemental Material

## Availability

The ARC-Finder is available for download at <https://github.com/Brilator/arcFinder>.

## Dependencies

### Software

\begin{longtable}[]{llllllll}
\caption[Placeholder or what?]{Software used during development, testing and writing.} \\
\toprule
Software & Version & Platform\tabularnewline
\midrule
\endhead
GNU bash & 3.2.57(1)-release & x86\_64-apple-darwin21\tabularnewline
curl & 7.79.1 & x86\_64-apple-darwin21.0\tabularnewline
R & 4.2.0 & x86\_64-apple-darwin17.0\tabularnewline
RStudio & 2022.02.2 Build 485 & -\tabularnewline
Visual Studio Code & 1.67.2 & -\tabularnewline
Codes Spell Checker (VS Code Extension) & 2.03 & -\tabularnewline
pandoc & 2.18 & -\tabularnewline
TeX Live 2022 & MacTeX-2022 & -\tabularnewline
\bottomrule
\end{longtable}

### R libraries

To provide best reproducibility, R package dependencies are handled via `renv`[^renv] (version 0.15.3) and stored in the root file "renv.lock". In the first step of `arcFinder`, the virtual environment is automatically restored, including installation of all required dependencies. Depending on the local setup (installation of R and packages), this may take some time. However, `renv` prevents interference with the local setup, thus keeping the system intact.

\begin{longtable}[]{llllllll}
\caption[]{R packages specifically loaded for individual R scripts} \\
\toprule
Package (version) & Main purpose & Used in script(s)\tabularnewline
\midrule
\endhead
renv\_0.15.4 & Manage R package dependencies & 01\_install\_dependencies.R\tabularnewline
& & 01\_restore\_dependencies.R\tabularnewline
readxl\_1.4.0 (part of `tidyverse`) & Read data from Microsoft Excel workbooks & 03\_parse\_isaInvxlsx.R\tabularnewline
tidyverse\_1.3.1 & Tidy data into a useful format & 04\_searchApp/app.R\tabularnewline
shiny\_1.7.1 & Prepare and launch a shiny app & 04\_searchApp/app.R\tabularnewline
DBI\_1.1.2 & Write data to an `*.sqlite` object & 05\_pull\_together\_sql.R\tabularnewline
\bottomrule
\end{longtable}

### Platform

The DataPLANT's DataHUB[^DataHUB] is a customized instance of GitLab[^GitLab], currently running under version 14.10.2, hosted and maintained by the DataPLANT node at Albert-Ludwigs-University Freiburg. Data is retrieved from the DataHUB via GitLab API version 4.  
After registration[^dpregister] with DataPLANT, users can share and access non-public ARCs via the DataHUB.
As explained in the `arcFinder`'s README, a GitLab private access token (PAT) needs to be generated within the DataHUB and provided to `arcFinder`.

## Checks and tests

Currently tested only under macOS Monterey 12.3.1 (x86_64-apple-darwin17.0, 64-bit) with software versions specified under [Dependencies](#dependencies).

## Deviation from the original concept

The originally proposed concept targeted an automated workflow for easier metadata-ingestion from previously published manuscripts into an the ISA model of an ARC.
As this workflow (a) targets a completely other "side" of the ARC and DataHUB environment and thus (b) comes with multiple additional and more complicated dependencies, it was omitted from the ARC-Finder presented here.

<!-- Footnotes -->

[^NFDI]: Nationale Forschungsdaten Infrastruktur, https://www.nfdi.de/
[^wilkinson2016]: Wilkinson, M., Dumontier, M., Aalbersberg, I. et al. The FAIR Guiding Principles for scientific data management and stewardship. Sci Data 3, 160018 (2016). https://doi.org/10.1038/sdata.2016.18
[^go-fair]: GO-FAIR, https://www.go-fair.org/fair-principles/
[^CEPLAS]: CEPLAS, <https://ceplas.eu>
[^DataPLANT]: DataPLANT, <https://nfdi4plants.de> 
[^dpregister]: DataPLANT registration, <https://register.nfdi4plants.org/>
[^DataHUB]: DataPLANT DataHUB, <https://git.nfdi4plants.org>
[^ARC]:  ARC specifications, <https://github.com/nfdi4plants/ARC-specification/>
[^ISA]: ISA Metadata Schema, <https://isa-tools.org/>
[^git]: Git, <https://git-scm.com/>
[^GitLab]: GitLab, <https://gitlab.com>
[^renv]: R package "renv", <https://rstudio.github.io/renv/>

<!-- Footnotes -->

\pagebreak

# Scripts

## arcFinder.sh

```bash
########################################################
### Create root folder for temporary data
########################################################

### If exists, remove and create fresh. 
### This is to prevent data piling.
### TODO Should probably be replaced with safer / better logic for debugging. TODO

if [ -d ".tmp/" ]; then
  rm -r .tmp/
  mkdir .tmp/
else
  mkdir .tmp/
fi

########################################################
### Resotre renv session
########################################################

echo "### Restore virtual environment"
echo "----------------------"

Rscript ./scripts/01_restore_dependencies.R 2>&1 >> .tmp/01.log

########################################################
### Read GitLab personal access token (PAT)
########################################################

### Read GitLab PAT from -p flag

while getopts p: flag
do
    case "${flag}" in
        p) gitlab_pat=${OPTARG};;
    esac
done

### Check if argument supplied with `-p` is a file.
### If yes, read that file. 
### If not, use the input (PAT as a string) directly

if [ -f "$gitlab_pat" ]; then
    echo "Using GitLab token stored in '$gitlab_pat'."    
    gitlab_pat=$(< $gitlab_pat)
fi

### check if string is empty

[ -z "$gitlab_pat" ] && printf "No GitLab token supplied or GitLab token is empty. \nReading from public ARCs only.\n"

########################################################
### Run gitlab reader
########################################################

echo "----------------------"
echo "### Step 01: Downloading metadata of available ARCs from the DataHUB."
echo "----------------------"

echo "log of 02_read_from_gitlab.sh" > .tmp/02.log
bash ./scripts/02_read_from_gitlab.sh -p "${gitlab_pat}" 2>&1 >> .tmp/02.log

########################################################
### Run xlsx parser
########################################################

## store paths of isa.investigation.xlsx files into variable 
## while loop
## - extract arc id from part of path
## - run script with arc id and path

echo "### Step 02: Structuring ARC metadata."
echo "----------------------"
echo "log of 03_parse_isaInvxlsx.R" > .tmp/03.log

invs=$(find .tmp/02_investigations -name '*.xlsx' | sort -n)
echo "$invs" | while IFS= read -r current_inv_path;
do 
  arc_id=$(echo $current_inv_path | cut -d/ -f3 | cut -d"_" -f1)  
    
  Rscript ./scripts/03_parse_isaInvxlsx.R "$arc_id" $current_inv_path 2>&1 >> .tmp/03.log

done


########################################################
### Pull together data
########################################################

echo "### Step 03: Building a searchable database of ARC metadata"
echo "----------------------"

Rscript ./scripts/03_pull_together.R 2>&1 >> .tmp/03.log

########################################################
### Optional: Prepare SQLite database
########################################################

Rscript ./scripts/05_pull_together_sql.R 2>&1 >> .tmp/05.log

########################################################
### Run the search APP
########################################################

echo "### Voila: The ARC Finder is running in your default browser."
echo "### Close the browser window or tab to shut down the app."

Rscript -e 'load(".tmp/03_allARCs.RData"); shiny::runApp("./scripts/04_searchApp/app.R", launch.browser = TRUE)' 2>&1 >> .tmp/04.log
```
\pagebreak

## README.md


### ARC-Finder &ndash; A simple, locally-deployed tool to find your peer's research data

This is a tool to help you find metadata about ARCs stored in the DataPLANT [DataHUB](https://git.nfdi4plants.org/).
Visit the [DataPLANT website](<https://nfdi4plants.de>) for more information about ARCs (annotated research contexts).

#### Usage

- Git clone or download this repository.
- Open a command line or terminal and navigate to the `arcFinder` directory.
- Run one of the following two options:

##### Option 1: Search public ARCs only

```bash
./arcFinder.sh
```

##### Option 2: Search Public + privately shared ARCs

> Note: Replace `<gitlab pat>` with the path pointing to a file which stores a GitLab personal access token (PAT).

```bash
./arcFinder.sh -p <gitlab pat>
```

##### Registration with DataPLANT

In order to use the `<gitlab pat>` option, please follow these steps:

1. [Sign up](<https://register.nfdi4plants.org/>) with DataPLANT.
2. Generate a personal access token in the [DataHUB PAT settings](https://git.nfdi4plants.org/-/profile/personal_access_tokens)
   - Provide a "Token name", e.g. `arcFinder`
   - Select either option "api" or "read_api" and click "Create personal access token"
   - Copy the generated token on top of the page.
3. Paste the bare token into a text file and save it (e.g. `gitlab_token` stored in the root of this directory)
4. Supply the file path to `arcFinder`, e.g.:

```bash
./arcFinder.sh -p gitlab_token
```
\pagebreak

## scripts/01_install_dependencies.R

```R
############################################################
### Script to install all R dependencies
############################################################


if(!require(tidyverse, quietly = TRUE)){install.packages("tidyverse")}
if(!require(DBI, quietly = TRUE)){install.packages("DBI")}
if(!require(shiny, quietly = TRUE)){install.packages("shiny")}
if(!require(renv, quietly = TRUE)){install.packages("renv")}

renv::init(bare = T)

# save library state to lockfile
renv::snapshot()

renv::status()
```

## scripts/01_restore_dependencies.R

```R

############################################################
### Restore R virtual environment via renv
############################################################

# restore lockfile, thereby installing dependencies from renv.lock

renv::restore()
```

## scripts/02_read_from_gitlab.sh

```bash
#!/usr/bin/env bash

############################################################
### Script to skim GitLab for accessible ARCs and 
### retreive their isa.investigation.xlsx's
############################################################

### Goal
# 1. read gitlab pat
# 2. Store a list of all available projects (e.g. tab)
# 3. Iterate over project trees
#   - check for isa.investigation file
#   - present: download raw and dump to temp
#   - absent: leave loop

############################
### Read GitLab token (PAT)
############################

### Read GitLab PAT from -p flag

while getopts p: flag
do
    case "${flag}" in
        p) gitlab_pat=${OPTARG};;
    esac
done

# ### Check if argument supplied with `-p` is a file.
# ### If yes, read that file. 
# ### If not, use the input (PAT as a string) directly

# if [ -f "$gitlab_pat" ]; then
#     echo "Using GitLab token stored in '$gitlab_pat'."
#     gitlab_pat=$(< $gitlab_pat)
# else 
#     echo "Using supplied GitLab token"
#     # This would be gitlab_pat=$gitlab_pat   ### TODO: probably safer to change this 
# fi

# ### check if string is empty

# [ -z "$gitlab_pat" ] && printf "No GitLab token supplied or GitLab token is empty. \nReading from public ARCs only.\n"


############################
### List available ARCs
############################

# Writing to json first 
curl --silent --request GET --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/" > .tmp/02_arcs_available.json

# grepping project IDs
grep -oE '"id":[0-9]{1,},"description"' .tmp/02_arcs_available.json | grep -oE '[0-9]{1,}' > .tmp/02_arcs_ids

# Could be piped directly (without the temporary .json)
# But will keep the json, for trouble-shooting
# curl --request GET --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/" | grep -oE '"id":[0-9]{1,},"description"' | grep -oE '[0-9]{1,}' > projects_list


############################
### Iterate over ARCS
############################

### create a dump directory for the isa.investigation.xlsx files
if ! [ -d ".tmp/02_investigations" ]; then mkdir ".tmp/02_investigations"; fi

### write a table to collect ARC id and path with namespace
printf "ARC id\tARC path\tcomment" > .tmp/02_investigations/arc_list.tsv

all_arc_IDs=$(< .tmp/02_arcs_ids)
echo "$all_arc_IDs" | while IFS= read -r arc_id;
do 
  # echo $arc_id

  ### get project info
  curl --silent --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/$arc_id" > .tmp/02_current_arc_info.json
  
  ### extract git path with namespace
  arc_path=$(grep -oE '"path_with_namespace":".*,"created_at' .tmp/02_current_arc_info.json | cut -d'"' -f 4)    

  echo $arc_path

  ### get project tree
  curl --silent --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/$arc_id/repository/tree" > .tmp/02_current_arc_tree.json

  ### check that file `isa.investigation.xlsx` exists at ARC root
  ### if yes: download and dump
  ### if no: error message
  
  inv_path=$(grep -oE '"path":"isa.investigation.xlsx",' .tmp/02_current_arc_tree.json)

  ### check if variable is empty
  if [ -z "$inv_path" ]
  then
    printf "Missing 'isa.investigation.xlsx' at the root of $arc_path\n"
    printf "\n$arc_id\t$arc_path\tisa.investigation.xlsx missing" >> .tmp/02_investigations/arc_list.tsv
  else
    curl -L --silent --request GET --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/$arc_id/repository/files/isa%2Einvestigation%2Exlsx/raw?ref=main" -o .tmp/02_investigations/$arc_id'_isa.inv.xlsx'
    printf "\n$arc_id\t$arc_path\tisa.investigation.xlsx detected" >> .tmp/02_investigations/arc_list.tsv
  fi  

  rm .tmp/02_current_arc*

done


```

## scripts/scripts/03_parse_isaInvxlsx.R

```R

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
# if(!require("readxl", quietly = TRUE)){install.packages("readxl")}

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
if(is.null(invdata)){stop(simpleError("No valid ISA investigation sheet detected"))}


########################
### wrangle / extract only relevant data
########################


### subset to investigation only (excluding study, assay layers)
investigation_data <- invdata[grepl("^investigation",  invdata[, 1], ignore.case = T), ]

### first column as row names
rownames(investigation_data) <- investigation_data[,1]
investigation_data2 <- investigation_data[,-1, drop = F]

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
  
  current_section <- investigation_data2[section_range, , drop =F]
  
  ### remove columns that are only NA
  current_section <- current_section[, apply(current_section, 2, function(x){sum(is.na(x)) != nrow(current_section)}), drop = F]
  
  ### transpose / pivot data to transform into list
  current_section_transposed <- as.data.frame(t(current_section))
  rownames(current_section_transposed) <- NULL
  
  # TODO stupid work-around to circumvent the bug with a section having only NAs
  if(nrow(current_section_transposed) == 0){current_section_transposed[1, ] = NA}
  
  current_section_transposed$arc_id <- arc_id
  
  ### extract current section name
  current_section_name <- row.names(investigation_data2)[inv_sections[i]]
  
  # ### transform to named list, omitting NAs
  # investigation_list[[current_section_name]] <- lapply(current_section_transposed, function(v){v[!is.na(v)]})
  # 
  # stack(current_section_transposed)
  
  investigation_list[[current_section_name]] <- current_section_transposed
  
}

########################
### output to .RData
########################

if(!dir.exists(".tmp/03_rdata_dumps/")){dir.create(".tmp/03_rdata_dumps/")}

print(paste0("Storing outputs in: .tmp/03_rdata_dumps/", arc_id, ".Rdata"))

save(investigation_list, isa_inv_wb, arc_id, file = paste0(".tmp/03_rdata_dumps/", arc_id, ".RData"))
```

## scripts/scripts/03_pull_together.R

```R
############################################################
### Script to pull together output of previous scripts
############################################################

### for loop over available RData dumps from 03_parse_isaInvxlsx.R

all_arcs <- list()

for(i in dir(".tmp/03_rdata_dumps/", full.names = T, pattern = ".RData"))
{
  ### load the data
  load(i)
  
  ### store in named list
  
  all_arcs[[arc_id]] <- investigation_list
    
}

### row-bind the second-level (i.e. INVESTIGATION "sections") of the lists, respectively

all_arcs_db <- do.call(Map, c(f = rbind, all_arcs))

### read the arc_list (translating the ARC id to the ARC path) produced by 02_read_from_gitlab.sh
### and append to above list

arc_list <- read.table(".tmp/02_investigations/arc_list.tsv", sep = "\t", header = T)
colnames(arc_list)[1] <- "arc_id"

# all_arcs_db[["arc_list"]] <- arc_list

### store the output as RData
 
save(all_arcs, all_arcs_db, arc_list, file = ".tmp/03_allARCs.RData")
```

## scripts/scripts/05_pull_together_sql.R

```R
############################################################
### Convert data into SQLite database
############################################################

# if(!require("DBI", quietly = TRUE)){install.packages("DBI")}
library(DBI)

load(".tmp/03_allARCs.RData")

### Write into an SQLite DB file

mydb <- dbConnect(RSQLite::SQLite(), "yourARCs_database.sqlite")

for(i in names(all_arcs_db))
{
  dbWriteTable(mydb, i, all_arcs_db[[i]], overwrite = T)
}

dbWriteTable(mydb, "ARC list", arc_list, overwrite = T)

dbListTables(mydb)
dbDisconnect(mydb)
```

## scripts/scripts/04_searchApp/app.R

```R
############################################################
### The ARC-Finder GUI Shiny App
############################################################

suppressMessages(library(tidyverse))
suppressMessages(library(shiny))

# load(".tmp/03_allARCs.RData")

### Flatten ALL values into a 3-column (arc_id | key | value) df to provide search across "any field"

all_values <- do.call(
  rbind.data.frame, lapply(all_arcs_db, function(x){
  pivot_longer(x, cols = setdiff(colnames(x), "arc_id"), values_drop_na = T)}))

all_values <- as.data.frame(all_values)

arc_list <- unique(arc_list)

shinyApp(
    ui = pageWithSidebar(
        headerPanel("ARC Finder"),
        sidebarPanel(
            selectizeInput('search_key', 'Select a field to search', choices = c("Any field", unique(all_values$name))),
            uiOutput("search_field"), 
            selectInput(inputId = "arc_path", label = "Select an ARC for details", choices = NULL),
            br(),
            actionButton("go", "Show this ARC"),
            h3("Access this ARC in the DataHUB"),
            uiOutput("arc_gitlab"),
             
        ),
        
        mainPanel(
          h3("Overview"),
          tableOutput("table_INV"),
          br(),
          h3("Publications"),
          tableOutput("table_INV_PUBS"),
          br(),
          h3("Contacts"),
          tableOutput("table_INV_Contacts")
        )
    ),
    
    server = function(input, output, session) {
      
      
      ##### reactive input field for text-search
          
        
      output$search_field <- renderUI({
        
        # check whether user wants to filter by cyl;
        # if not, then filter by selection
        if ('Any field' %in% input$search_key) {
            df <- all_values
        } else {
            df <- subset(all_values, name == input$search_key)
        }
        
      
      selectizeInput('search_value', 'Search the ARC database', choices = c("", sort(unique(df$value))))
      
      })
      
      
      ##### ARC choices (arc_id) matching user-input
      
        arc_choices_id <- reactive({ 
          
        if ('Any field' %in% input$search_key) {
            
          subset(all_values, value == input$search_value, arc_id, drop = T)
          
          } else {
          
          subset(all_values, name == input$search_key & value == input$search_value, arc_id, drop = T)
          }
          
        })
      
        
        ### retrieve path for matching ARCs from arc list
        
        arc_choices_path <- reactive({
        
        subset(arc_list, arc_id %in% arc_choices_id(), ARC.path, drop = T)
      
        })

      ##### reactive ARC selection: updated Input to let user pick from 
          
        
        observe({
          updateSelectInput(session = session, inputId = "arc_path", choices = arc_choices_path())
          })
        
        
     #### User's ARC choice 
        
        selected_arc <- eventReactive(input$go, {
        
        all_arcs[[as.character(subset(arc_list, ARC.path %in% input$arc_path, arc_id, drop = T))]]
      
        })
      
        
      ##### render table INVESTIGATION 
        
        output$table_INV <- renderTable(colnames = F, rownames = F, {
          
          selected_table <- selected_arc()$INVESTIGATION
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]
          
          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
          
        })        
      
      ##### render table INVESTIGATION PUBLICATIONS
        
        output$table_INV_PUBS <- renderTable(colnames = F, rownames = F, {
          
          selected_table <- selected_arc()$`INVESTIGATION PUBLICATIONS`
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]
          
          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
          
          
        })
        
      ##### render table INVESTIGATION CONTACTS
        
        output$table_INV_Contacts <- renderTable(colnames = F, rownames = F, {
          
          
          selected_table <- selected_arc()$`INVESTIGATION CONTACTS`
          selected_table <- selected_table[, -which(colnames(selected_table) == "arc_id")]

          selected_table$pivot_col <- row.names(selected_table)
          long <- pivot_longer(selected_table, setdiff(colnames(selected_table), "pivot_col"), values_drop_na = T)
          
          pivot_wider(long, names_from = pivot_col)
            
        })
        
    ##### render link to gitlab

        output$arc_gitlab <- renderUI(a(href = paste0('https://git.nfdi4plants.org/', input$arc_path), 
                                        paste0('https://git.nfdi4plants.org/', input$arc_path) ,target="_blank"))
        
        
        session$onSessionEnded(function() {
          stopApp()
        })
    }
    
)
          





```

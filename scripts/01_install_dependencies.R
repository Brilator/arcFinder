
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



install.packages(c("dbplyr", "RSQLite"))

library(RSQLite)
library(dplyr)
library(dbplyr)

dir.create("data_raw")
download.file("https://ndownloader.figshare.com/files/3299483", "data_raw/species.csv")
download.file("https://ndownloader.figshare.com/files/10717177", "data_raw/surveys.csv")
download.file("https://ndownloader.figshare.com/files/3299474", "data_raw/plots.csv")

library(tidyverse)
species <- read_csv("data_raw/species.csv")
surveys <- read_csv("data_raw/surveys.csv")
plots <- read_csv("data_raw/plots.csv")


my_db_file <- "data/portal-database-output.sqlite"
# my_db <- src_sqlite(my_db_file, create = TRUE) ### deprecated
# my_db <- tbl(my_db_file)
# 


library(DBI)

mydb <- dbConnect(RSQLite::SQLite(), "my-db.sqlite")
dbDisconnect(mydb)

# mydb <- dbConnect(RSQLite::SQLite(), "")
dbWriteTable(mydb, "mtcars", mtcars)
dbWriteTable(mydb, "iris", iris)
dbListTables(mydb)
dbDisconnect(mydb)


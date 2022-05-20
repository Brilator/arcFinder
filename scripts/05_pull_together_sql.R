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








############################################################
### Restore R virtual environment via renv
############################################################

# restore lockfile, thereby installing dependencies from renv.lock

if(!require(renv, quietly = TRUE)){install.packages("renv")}
renv::restore()

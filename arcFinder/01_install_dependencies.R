
############################################################
### Script to install all R dependencies
############################################################

required_packages <- c("tidyverse", "DBI", "shiny")

for(package in required_packages)
{
  ## Check if package is installed. If not, install
  if(!require(package, quietly = TRUE)){install.packages(package)}
}


############################################################
### Script to pull together output of 03_parse_isaInvxlsx.R
############################################################

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
save(all_arcs_db, file = ".tmp03_allARCs.RData")


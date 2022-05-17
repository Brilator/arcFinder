############################################################
### Script to pull together output of 03_parse_isaInvxlsx.R
############################################################

all_arcs <- list()

for(i in dir(".tmp03_rdata_dumps/", full.names = T))
{
  
  load(i)
  investigation_list$INVESTIGATION
  
  all_arcs[[arc_id]] <- investigation_list
    
}

save(all_arcs, file = ".tmp03_allARCs.RData")



all_arcs$`16`$INVESTIGATION


### rowbind by investigation section
library(tidyverse)
all_arcs_unlisted <- unlist(all_arcs, recursive = F)
test <- flatten(all_arcs)


do.call(function(x){rbind(unlist(x, recursive = F))}, all_arcs)

all_arcs_df <- lapply(all_arcs, rbind.data.frame)


names(unlist(all_arcs, recursive = F))

cols <- unique(unlist(lapply(all_arcs, names)))

another_test <- map(all_arcs, `[`, cols) %>% map(bind_rows)


lapply(all_arcs, names)

do.call(intersect, lapply(all_arcs, names))

intersect(names(all_arcs$`16`), names(all_arcs$`33`))



# library(purrr)
# lapply(transpose(all_arcs), function(x) do.call(rbind, x))


do.call(Map, c(f = rbind, all_arcs))


all_arcs$`77`$`INVESTIGATION CONTACTS`

all_arcs_unlisted



if(!require("jsonlite", quietly = TRUE)){install.packages("jsonlite")}
library(jsonlite)


all_arcs_json <- toJSON(all_arcs, pretty = F)
all_arcs_json <- serializeJSON(all_arcs, pretty = F)
write_json(all_arcs_json, path = "all_arcs.json")


library(tidyverse)
dt <- tibble(all_arcs$`16`)

dt %>% unnest_wider(simplify = FALSE)



df <- tibble(json = all_arcs$`16`)

# The defaults of `unnest_wider()` treat empty types (like `list()`) as `NULL`.
# This chains nicely into `unnest_longer()`.
wide <- unnest_wider(df, json)
wide


longer <- unnest_longer(wide, c(names(all_arcs$`16`$`INVESTIGATION CONTACTS`)))


wide <- unnest_wider(df, json, simplify = T)
longer <- unnest(wide, c(names(all_arcs$`16`$`INVESTIGATION CONTACTS`)), keep_empty = T)




# 
# df <- tibble(
#   character = c("Toothless", "Dory"),
#   metadata = list(
#     list(
#       species = "dragon",
#       color = "black",
#       films = c(
#         "How to Train Your Dragon",
#         "How to Train Your Dragon 2",
#         "How to Train Your Dragon: The Hidden World"
#       )
#     ),
#     list(
#       species = "blue tang",
#       color = "blue",
#       films = c("Finding Nemo", "Finding Dory")
#     )
#   )
# )
# 
# df %>% unnest_wider(metadata, simplify = FALSE)
# 



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
curl --silent --request GET --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/" > .tmp02_arcs_available.json

# grepping project IDs
grep -oE '"id":[0-9]{1,},"description"' .tmp02_arcs_available.json | grep -oE '[0-9]{1,}' > .tmp02_arcs_ids

# Could be piped directly (without the temporary .json)
# But will keep the json, for trouble-shooting
# curl --request GET --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/" | grep -oE '"id":[0-9]{1,},"description"' | grep -oE '[0-9]{1,}' > projects_list


############################
### Iterate over ARCS
############################

### create a dump directory for the isa.investigation.xlsx files
if ! [ -d ".tmp02_investigations" ]; then mkdir ".tmp02_investigations"; fi

### write a table to collect ARC id and path with namespace
printf "ARC id\tARC path\tcomment" > .tmp02_investigations/arc_list.tsv

all_arc_IDs=$(< .tmp02_arcs_ids)
echo "$all_arc_IDs" | while IFS= read -r arc_id;
do 
  # echo $arc_id

  ### get project info
  curl --silent --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/$arc_id" > .tmp02_current_arc_info.json
  
  ### extract git path with namespace
  arc_path=$(grep -oE '"path_with_namespace":".*,"created_at' .tmp02_current_arc_info.json | cut -d'"' -f 4)    

  echo $arc_path

  ### get project tree
  curl --silent --header "PRIVATE-TOKEN: $gitlab_pat" "https://git.nfdi4plants.org/api/v4/projects/$arc_id/repository/tree" > .tmp02_current_arc_tree.json

  ### check that file `isa.investigation.xlsx` exists at ARC root
  ### if yes: download and dump
  ### if no: error message
  
  inv_path=$(grep -oE '"path":"isa.investigation.xlsx",' .tmp02_current_arc_tree.json)

  ### check if variable is empty
  if [ -z "$inv_path" ]
  then
    printf "Missing 'isa.investigation.xlsx' at the root of $arc_path\n"
    printf "\n$arc_id\t$arc_path\tisa.investigation.xlsx missing" >> .tmp02_investigations/arc_list.tsv
  else
    curl --silent --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/$arc_id/repository/files/isa.investigation.xlsx/raw?ref=main" -o .tmp02_investigations/$arc_id'_isa.inv.xlsx'
    printf "\n$arc_id\t$arc_path\tisa.investigation.xlsx detected" >> .tmp02_investigations/arc_list.tsv
  fi  

  rm .tmp02_current_arc*

done



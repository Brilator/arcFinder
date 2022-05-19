########################################################
### Pull together data
########################################################

echo "### Restore virtual environment"
echo "----------------------"

Rscript 01_restore_dependencies.R 2>&1 >> .tmp01.log

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
    gitlab_pat=$(< gitlab_token)
    # gitlab_pat=$(< $gitlab_pat)
else 
    echo "Using supplied GitLab token"
    # This would be gitlab_pat=$gitlab_pat   ### TODO: probably safer to change this 
fi

### check if string is empty

[ -z "$gitlab_pat" ] && printf "No GitLab token supplied or GitLab token is empty. \nReading from public ARCs only.\n"


########################################################
### Run gitlab reader
########################################################

echo "----------------------"
echo "### Step 01: Downloading metadata of available ARCs from the DataHUB."
echo "----------------------"

echo "log of 02_read_from_gitlab.sh" > .tmp02.log
bash 02_read_from_gitlab.sh -p "${gitlab_pat}" 2>&1 >> .tmp02.log

########################################################
### Run xlsx parser
########################################################

## store paths of isa.investigation.xlsx files into variable 
## while loop
## - extract arc id from part of path
## - run script with arc id and path

echo "### Step 02: Structuring ARC metadata."
echo "----------------------"
echo "log of 03_parse_isaInvxlsx.R" > .tmp03.log

invs=$(find .tmp02_investigations/ -name '*.xlsx' | sort -n)
echo "$invs" | while IFS= read -r current_inv_path;
do 
  
  arc_id=$(echo $current_inv_path | cut -d/ -f3 | cut -d"_" -f1)  
  
  Rscript 03_parse_isaInvxlsx.R "$arc_id" $current_inv_path 2>&1 >> .tmp03.log

done


########################################################
### Pull together data
########################################################

echo "### Step 03: Building a searchable database of ARC metadata"
echo "----------------------"

Rscript 03_pull_together.R 2>&1 >> .tmp03.log

########################################################
### Optional: Prepare SQLite database
########################################################

Rscript 05_pull_together_sql.R 2>&1 >> .tmp05.log

########################################################
### Run the search APP
########################################################

echo "### Voila: The ARC Finder is running in your default browser."
echo "### Close the browser window or tab to shut down the app."

Rscript -e 'shiny::runApp("04_searchApp/", launch.browser = TRUE)' 2>&1 >> .tmp04.log

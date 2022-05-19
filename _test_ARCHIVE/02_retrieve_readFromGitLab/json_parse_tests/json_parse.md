
## Goal 

- Extract the git ids, title, etc. to tabular
- Try to achieve this without other dependencies (e.g. tool `jq`)

```bash
grep -o '"id": "[^"]*' list_all_projects.json

grep -o '"id":' list_all_projects.json # works, shows just id
grep -o '"id":[0-9]' list_all_projects.json # works, shows id and first digit

grep -oE '"id":[0-9]{1,}' list_all_projects.json # YES! 
```

gitlab people also have an id... 

    "id": 31,
    "description": "",
    "name": "SampleARC_Proteomics",

```bash
grep -oE '"id":[[:digit:]]*,"description"' list_all_projects.json ## adding "description" to exclude people ids

grep -oE '"id":[[:digit:]]*,"description"' list_all_projects.json | grep -oE '[[:digit:]]*' > projects_list
grep -oE '"id":[0-9]{1,},"description"' list_all_projects.json | grep -oE '[0-9]{1,}' > projects_list   ### safer than "digit"? 

grep -oE '"id":[0-9]{1,},"description":"[a-z]{0,}","name":' list_all_projects.json
grep -oE '"id":[0-9]{1,},"description":"[a-z]{0,}","name":"*"' list_all_projects.json
grep -oE '"id":[0-9]{1,},"description":"[a-z]{0,}","name":"\K[ A-Za-z0-9]*"' list_all_projects.json
```



```bash
# extract anything between name and name_with_namespace and cut it
grep -oE '"name":".*,"name_with_namespace' .tmp_current_arc_info.json | grep -oE ":.*," | cut -d'"' -f 2 
grep -oE '"name":".*,"name_with_namespace' .tmp_current_arc_info.json | cut -d'"' -f 4
```
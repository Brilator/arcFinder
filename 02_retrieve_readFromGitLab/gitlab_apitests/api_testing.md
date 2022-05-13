
# GitLab API tests

## Docs

https://docs.gitlab.com/ee/api/projects.html

## Tests

### get repo info (public)

```bash
curl https://git.nfdi4plants.org/api/v4/projects/33 > get_project.json
```

### get repo info (private)

```bash
curl https://git.nfdi4plants.org/api/v4/projects/52 > get_private_project.json
```
> ERROR: needs authentication

```bash
gitlab_token=$(< gitlab_token)
curl --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/52"
```

### Can token be empty?

```bash
no_gitlab_token=""
curl --header "PRIVATE-TOKEN: $no_gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33"
curl --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33"
```

GOOD!

### list repo tree

```bash
curl "https://git.nfdi4plants.org/api/v4/projects/33/repository/tree"  > get_project_tree.json
```

### list all public repos

API call: `GET /projects`

```bash
curl --request GET "https://git.nfdi4plants.org/api/v4/projects/" > list_public_projects.json
```

### list all accessible projects

```bash
curl --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/" > list_all_projects.json
```


### Get a specific file

Docs: https://docs.gitlab.com/ee/api/repository_files.html
API call: `GET /projects/:id/repository/files/:file_path`

cat get_project_tree.json

- Id of the file `isa.investigation.xlsx` is `40636f8405bed6a4c29a5ac631870be02ed2e15d`

```bash
curl --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33/repository/files/isa.investigation.xlsx?ref=main"

curl --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33/repository/files/40636f8405bed6a4c29a5ac631870be02ed2e15d?ref=main"
```

### get a specific raw file

Docs: https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
API call: `GET /projects/:id/repository/files/:file_path/raw`

```bash
curl --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33/repository/files/README.md/raw?ref=main" > project_readme_raw

### public project
curl --request GET --header "PRIVATE-TOKEN: $gitlab_token" "https://git.nfdi4plants.org/api/v4/projects/33/repository/files/isa.investigation.xlsx/raw?ref=main" > project_isaInvestigation.xlsx

unzip project_isaInvestigation.xlsx -d project_isaInvestigation.xlsx_unzipped

```



----
----

##### Note for later: for looping multiple projects

```bash
for project_id in 321 456 987; do
    curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" \
         --header "Content-Type: application/json" \
         --data '{"title": "my key", "key": "ssh-rsa AAAA..."}' \
         "https://gitlab.example.com/api/v4/projects/${project_id}/deploy_keys"
done
```

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
--header "PRIVATE-TOKEN: $gitlab_token"
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


# testing gitlab API

> ssh://git@gitlab.nfdi4plants.de:/brilator/20220211_gitlab_apitests.git


# get repo info (public)
curl "https://gitlab.nfdi4plants.de/api/v4/projects/130/" > get_project

# get repo info (private)
curl "https://gitlab.nfdi4plants.de/api/v4/projects/117"

https://gitlab.nfdi4plants.de/brilator/flaveria_circadian_arc

# list repo tree
curl "https://gitlab.nfdi4plants.de/api/v4/projects/130/repository/tree"  > get_project_tree



# list all repos of a group

> GET /groups/:id/projects
> https://gitlab.nfdi4plants.de/ceplas/gradschool2021
> group id: 41

curl "https://gitlab.nfdi4plants.de/api/v4//groups/41/projects"


# Retrieving (publication) metadata from DataCite

Source: https://support.datacite.org/reference/get_dois-id (28.02.2022)

```bash
curl --request GET \
    --url https://api.datacite.org/dois/10.1155%2F2014%2F413629 \
    --header 'Accept: application/vnd.api+json'
```

```bash
curl --request GET \
    --url https://api.datacite.org/dois/10.1104/pp.15.01076 \
    --header 'Accept: application/vnd.api+json'
```
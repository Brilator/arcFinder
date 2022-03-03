
# Retrieving (publication) metadata from Crossref

Tutorial:

https://www.crossref.org/documentation/retrieve-metadata/rest-api/a-non-technical-introduction-to-our-api/

```bash
curl https://api.crossref.org/works/10.1155/2014/413629 > crossref.json
```


curl https://api.crossref.org/works/10.1104/pp.15.01076 > mypaper.json

## Different output formats


see 
* https://www.crossref.org/documentation/retrieve-metadata/content-negotiation/
* https://citation.crosscite.org/docs.html

curl -D - -L -H "Accept: application/rdf+xml" "https://doi.org/10.1126/science.1157784"

curl -D - -L -H "Accept: application/rdf+xml" "https://doi.org/10.1104/pp.15.01076"
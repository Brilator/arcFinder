
# Collect: ingest to GitLab

## Automated

1. Select 10 random CEPLAS publications
    1. collect DOIs in a list
1. read citation data from crossref or datacite
    1. Loop over DOI list and dump into folder
    2. format?

### To isa.json

1. understand isa.json format
1. test isa.api <https://isa-tools.org/isa-api/content/creationtutorial.html>
    1. Create simple isa investigation object
    1. Test arcCommander conversion / reading from isa.json 
1. Map attributes from DOI refs to isa.json
1. Write isa.json based on DOI (python?)
1. Convert isa.json to isa.investigation.xlsx via arcCommander

### To isa.investigation.xlsx

1. Write "directly" into isa.investigation.xlsx based on citations

## Alternative: manually

1. Select 10 random CEPLAS publications
1. Create dummy ARCs based on citations, writing directly into isa.investigation.xlsx

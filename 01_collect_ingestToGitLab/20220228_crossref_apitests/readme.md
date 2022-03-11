
# Retrieving (publication) metadata from Crossref

Tutorial:

<https://www.crossref.org/documentation/retrieve-metadata/rest-api/a-non-technical-introduction-to-our-api/>

```bash
curl https://api.crossref.org/works/10.1155/2014/413629 > crossref.json
```

```bash
curl <https://api.crossref.org/works/10.1104/pp.15.01076> > mypaper.json
```

## Different output formats

see

* <https://www.crossref.org/documentation/retrieve-metadata/content-negotiation/>
* <https://citation.crosscite.org/docs.html>

curl -D - -L -H "Accept: application/rdf+xml" "https://doi.org/10.1126/science.1157784"

curl -D - -L -H "Accept: application/rdf+xml" "https://doi.org/10.1104/pp.15.01076"

```bash
curl -D - -LH "Accept: application/x-bibtex" https://doi.org/10.1104/pp.15.01076  > mypaper.bibtex

curl -D - -LH "Accept: application/x-research-info-systems" https://doi.org/10.1104/pp.15.01076  > mypaper.ris

curl -D - -LH "Accept: application/x-bibtex" https://doi.org/10.1007/978-3-642-79060-7  > book_example.bibtex
curl -D - -LH "Accept: application/x-research-info-systems" https://doi.org/10.1007/978-3-642-79060-7  > book_example.ris



```

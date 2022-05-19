
<!-- 
https://learnbyexample.github.io/customizing-pandoc/

```
pandoc README.md \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V geometry:margin=1.5cm \
    --pdf-engine=xelatex \ 
    -o 20220302_ZKFDM_Modul9_Konzept_Brilhaus.pdf
```
-->

# ARC-Finder &ndash; a simple, locally-deployed tool to find your peer's research data

> Konzept für das Projektmodul (Modul 9) des Zertifikatskurs FDM (15.07) 2021 / 2020  
> Teilnehmer: Dominik Brilhaus  
> ORCID: <https://orcid.org/0000-0001-9021-3197>  
> Email: brilhaus@hhu.de

- [Motivation](#motivation)
- [State of the art](#state-of-the-art)
- [Approach](#approach)
- [Caveats and places for future improvements](#caveats-and-places-for-future-improvements)
  - [isa.investigation.xlsx](#isainvestigationxlsx)
  - [branches](#branches)
  - [efficiency](#efficiency)
- [Dependencies](#dependencies)
  - [Software dependencies](#software-dependencies)
  - [Platform / access dependencies](#platform--access-dependencies)
- [Checks and tests](#checks-and-tests)
  - [TODO](#todo)
- [User instructions](#user-instructions)
  - [gitlab token](#gitlab-token)
  - [Permissions](#permissions)
- [Lessons learned](#lessons-learned)

## Motivation

Research is a highly collaborative endeavour that builds on synergistic interaction between different stakeholders enabled by efficient knowledge exchange. Gaining a prompt overview of the ongoing research efforts &ndash; both pre- and post-publication &ndash; is oftentimes hindered (for social, legal or technical reasons) even between parties of spatially closest and well trusted surroundings of a collaborative consortium such as the Cluster of Excellence on Plant Sciences (CEPLAS[^CEPLAS]). The key to enable discussion on and exchange of research data is *findability*, the first layer of the FAIR principles of data stewardship. The project presented here aims to address this layer, by making CEPLAS research easily findable and visible amongst CEPLAS researchers and showcase the beauty and ease of data sharing to spike fruitful collaborations with peers.

## State of the art

Research data management within CEPLAS is closely aligned with DataPLANT[^DataPLANT], the NFDI consortium for plant sciences. DataPLANT has developed the Annotated Research Context (ARC[^ARC]), a directory structure for research objects. Annotation of research data in the ARC is based on the metadata schema ISA[^ISA] (for investigation &ndash; study &ndash; assay). Serialized in spread sheet format as *ISA-tab* this allows intuitive, flexible and yet structured and conclusive metadata annotation of the versatile data types produced in plant sciences. ARCs are git[^git] repositories that can be shared via DataPLANT's DataHUB[^DataHUB], a customized GitLab[^GitLab] instance with a federated authentication interface to allow controlled access across institute borders.
Although the ARC environment is continuously being developed, the choice of these key technical pillars are set: (a) ARC as the structure, (b) ISA as the metadata language, (c) git as version control logic and (d) gitlab for ARC collaboration and user management. This allows to leverage the ARC and develop at least intermediate solutions for data findability, knowing that time and efforts are well-invested, since both (meta)data inputs in as well as secondary outputs dependent on the ARC will be adoptable and migratable in the future.

## Approach

This project focuses on metadata at the highest project and least sensitive (i.e. ISA's "investigation") level to minimize user input or possible discomfort with data sharing and will be achieved in four concerted, but independent modules of metadata

1. collection,
1. retrieval,
1. restructure, and
1. representation.

First, metadata is collected &ndash; manually or supported by automation &ndash; in the ISA investigation spread sheet, packaged in ARCs and submitted to the DataHUB by individual volunteers. Here, access to the ARCs can be controlled to share them publicly or with invited collaborators. The CEPLAS-ARC-Finder selectively retrieves, downloads and dumps the metadata locally on the user's machine. The CEPLAS-ARC-Finder then restructures the metadata into a simple spreadsheet-based database. From the database the investigation data is finally read and represented by a user interface that enables finding the data available to the individual user.

<!-- Footnotes -->

[^CEPLAS]: <https://ceplas.eu> "CEPLAS"
[^DataPLANT]: <https://nfdi4plants.de> "DataPLANT"
[^DataHUB]: <https://git.nfdi4plants.org> "ARC DataHUB"
[^ARC]: <https://github.com/nfdi4plants/ARC> "ARC specifications"
[^ISA]: <https://isa-tools.org/> "ISA Metadata Schema"
[^git]: <https://git-scm.com/> "Git"
[^GitLab]: <https://gitlab.com> "GitLab"

----

## Caveats and places for future improvements

### isa.investigation.xlsx

- read from isa.json rather than isa.investigation.xlsx
- Rationale: yet another detour / dependency to produce isa.json
- direct user-input to isa.investigation.xlsx can be read immediately
- xlsx can become big and needs to be dumped
- json could be read on-the-fly

### branches

- reading only from default git branch `main` (not e.g. master or others)

### efficiency

- tool dumps, pulls freshly every time it is called
  - nothing memorized and updated
  - by design sqlite db is always overwritten -> data could be appended
- selectivity
  - not all ARCs, but just selection (e.g. group)
  - error-prone: non-clean ARCs

## Dependencies

### Software dependencies

script name | Environment | Package
---------|----------|---------
03_parse_isaInvxlsx.R | R | readxl_1.4.0

### Platform / access dependencies

1. [^DataHUB] gitlab access token -> to retrieve data from non-public ARCs

## Checks and tests

Currently tested only under the following constellation

- bash and zsh
- macOS Monterey 12.3.1, Platform: x86_64-apple-darwin17.0 (64-bit)
- R version 4.2.0 (2022-04-22)

### TODO

- ARCs in (sub)groups

## User instructions

### gitlab token

1. Generate a personal access token (PAT) at DataHUB
2. Two options to use the PAT
   - store the PAT in a file and use this in the script XXX  {### TODO}
   - directly paste the token as argument to script XXX
3. Supplying a "wrong token" (i.e. any non-sense string) currently breaks the script.

### Permissions

- make all bash scripts executable?

## Lessons learned

- first time really making use of an API
- first time thinking about
  - dependencies
  - where to put what
  - logs

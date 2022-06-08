---
title: "ARC-Finder &ndash; A simple, locally-deployed tool to find your peer's research data"
author: [Dominik Brilhaus, <https://orcid.org/0000-0001-9021-3197>]
date: "2022-06-09"
keywords: [Metadata, ARC, DataPLANT]
subtitle: "Projektmodul (Modul 9) des Zertifikatskurs FDM (15.07) 2021 / 2022"
lang: "en"
titlepage: true
titlepage-color: "2D3E50"
titlepage-text-color: "FFC000"
titlepage-rule-color: "FFC000"
titlepage-rule-height: 2
header-includes:

- \usepackage{longtable, array, booktabs}
...

<!-- quickfix: For some weird reason the latex packages now have to be loaded first, when using a latex table with the eisvogel template. -->
<!-- used to work just fine without yesterday....  -->
<!-- pandoc template from: https://github.com/Wandmalfarbe/pandoc-latex-template -->
<!-- pandoc project.md -o project.pdf --from markdown --template eisvogel --listings -->

# Contents

- [Introduction](#introduction)
  - [Motivation](#motivation)
  - [State of the art](#state-of-the-art)
- [Approach](#approach)
  - [Technical back-end](#technical-back-end)
  - [Data safety](#data-safety)
- [Discussion](#discussion)
  - [Caveats and places for future improvements](#caveats-and-places-for-future-improvements)
- [Supplemental Material](#supplemental-material)
  - [Availability](#availability)
  - [Dependencies](#dependencies)
  - [Checks and tests](#checks-and-tests)
  - [Deviation from the original concept](#deviation-from-the-original-concept)
- [Scripts](#scripts)

<!-- the horizontal line is for auto-TOC with VS extension -->
----

\pagebreak

# Introduction

## Motivation

Research is a highly collaborative endeavor that builds on synergistic interaction between different stakeholders enabled by efficient knowledge exchange. Gaining a prompt overview of the ongoing research efforts &ndash; both pre- and post-publication &ndash; is oftentimes hindered (for social, legal or technical reasons) even between parties of spatially closest and well trusted surroundings of a collaborative consortium such as the Cluster of Excellence on Plant Sciences (CEPLAS[^CEPLAS]). The key to enable discussion on and exchange of research data is *findability*, the first layer of the FAIR principles of data stewardship. The project presented here aims to address this layer, by making CEPLAS research easily findable and visible amongst CEPLAS researchers and showcase the beauty and ease of data sharing to spike fruitful collaborations with peers.

## State of the art

Research data management within CEPLAS is closely aligned with DataPLANT[^DataPLANT], the NFDI consortium for plant sciences. DataPLANT has developed the Annotated Research Context (ARC[^ARC]), a directory structure for research objects. Annotation of research data in the ARC is based on the metadata schema ISA[^ISA] (for investigation &ndash; study &ndash; assay). Serialized in spread sheet format as *ISA-tab* this allows intuitive, flexible and yet structured and conclusive metadata annotation of the versatile data types produced in plant sciences. ARCs are git[^git] repositories that can be shared via DataPLANT's DataHUB[^DataHUB], a customized GitLab[^GitLab] instance with a federated authentication interface to allow controlled access across institute borders.
Although the ARC environment is continuously being developed, the choice of these key technical pillars are set: (a) ARC as the structure, (b) ISA as the metadata language, (c) git as version control logic and (d) gitlab for ARC collaboration and user management. This allows to leverage the ARC and develop at least intermediate solutions for data findability, knowing that time and efforts are well-invested, since both (meta)data inputs in as well as secondary outputs dependent on the ARC will be adoptable and migratable in the future.

# Approach

## Technical back-end

The technical back-end of the ARC-Finder is a combination of shell and R scripts and leveraging on the GitLab API (version 4). The idea was to rely on as few code environments as possible. The actual code work is attached in the supplemental materials (see [scripts](#scripts)) and available online (see [availability](#availability)). Software dependencies are listed in the supplemental materials (see [dependencies](#dependencies)).

## Data safety

This project focuses on metadata at the highest project and least sensitive (i.e. ISA's "investigation") level to minimize user input or possible discomfort with data sharing and will be achieved in four concerted, but independent modules of metadata

1. collection,
1. retrieval,
1. restructure, and
1. representation.

First, metadata is collected &ndash; manually or supported by automation &ndash; in the ISA investigation spread sheet, packaged in ARCs and submitted to the DataHUB by individual volunteers. Here, access to the ARCs can be controlled to share them publicly or with invited collaborators. The CEPLAS-ARC-Finder selectively retrieves, downloads and dumps the metadata locally on the user's machine. The CEPLAS-ARC-Finder then restructures the metadata into a simple spreadsheet-based database. From the database the investigation data is finally read and represented by a user interface that enables finding the data available to the individual user.

![ARC-Finder Workflow. First, the ARC-Finder retrieves accessible data from the DataHUB (1). Depending on user-choice and provided access token either publicly available (1a) or public plus privately shared (1b) ARCs are read and stored in a local data dump.](slides/2022-06-10_arcFinder_slides_brilhaus/2022-06-10_arcFinder_slides_brilhaus.001.png)

![ARC-Finder GUI.](slides/2022-06-10_arcFinder_slides_brilhaus/2022-06-10_arcFinder_slides_brilhaus.002.png)

# Discussion

- The arcFinder provides a comparably easy approach
- Can immediately be used
  - I can add my ARC to the DataHUB and have it directly listed by the arcFinder

- One of the major hurdles in advocating FAIR data stewardship to the users is the continuously changing plethora of platforms, tools and schema.
- Integrable with future developments to avoid user friction

- Extensibility (within DataPLANT: beauty of standards )
  - Designed on purpose limited. User.
  - Show-case how use of standards can boost sustainable research data management.
  - Vehicle for communication
  - While most tools in DataPLANT are based on other programming languages…

- SQL Alternative

## Caveats and places for future improvements

### isa.investigation.xlsx

- read from isa.json rather than isa.investigation.xlsx
- Rationale: yet another detour / dependency to produce isa.json
- direct user-input to isa.investigation.xlsx can be read immediately
- xlsx can become big and needs to be dumped
- json could be read on-the-fly

### group-associated ARCs

- are currently excluded

### branches

- reading only from default git branch `main` (not e.g. master or others)

### efficiency

- tool dumps, pulls freshly every time it is called
  - nothing memorized and updated
  - by design sqlite db is always overwritten -> data could be appended
- selectivity
  - not all ARCs, but just selection (e.g. group)
  - error-prone: non-clean ARCs

### Scalability

- CI / CD, public access / deployment

\pagebreak

# Supplemental Material

## Availability

The ARC-Finder is available for download at <https://github.com/Brilator/arcFinder>.

## Dependencies

### Software

\begin{longtable}[]{llllllll}
\caption[Placeholder or what?]{Software used during development, testing and writing.} \\
\toprule
Software & Version & Platform\tabularnewline
\midrule
\endhead
GNU bash & 3.2.57(1)-release & x86\_64-apple-darwin21\tabularnewline
curl & 7.79.1 & x86\_64-apple-darwin21.0\tabularnewline
R & 4.2.0 & x86\_64-apple-darwin17.0\tabularnewline
RStudio & 2022.02.2 Build 485 & -\tabularnewline
Visual Studio Code & 1.67.2 & -\tabularnewline
Codes Spell Checker (VS Code Extension) & 2.03 & -\tabularnewline
pandoc & 2.18 & -\tabularnewline
TeX Live 2022 & MacTeX-2022 & -\tabularnewline
\bottomrule
\end{longtable}

### R libraries

To provide best reproducibility, R package dependencies are handled via `renv`[^renv] (version 0.15.3) and stored in the root file "renv.lock". In the first step of `arcFinder`, the virtual environment is automatically restored, including installation of all required dependencies. Depending on the local setup (installation of R and packages), this may take some time. However, `renv` prevents interference with the local setup, thus keeping the system intact.

\begin{longtable}[]{llllllll}
\caption[]{R packages specifically loaded for individual R scripts} \\
\toprule
Package (version) & Main purpose & Used in script(s)\tabularnewline
\midrule
\endhead
renv\_0.15.4 & Manage R package dependencies & 01\_install\_dependencies.R\tabularnewline
& & 01\_restore\_dependencies.R\tabularnewline
readxl\_1.4.0 (part of `tidyverse`) & Read data from Microsoft Excel workbooks & 03\_parse\_isaInvxlsx.R\tabularnewline
tidyverse\_1.3.1 & Tidy data into a useful format & 04\_searchApp/app.R\tabularnewline
shiny\_1.7.1 & Prepare and launch a shiny app & 04\_searchApp/app.R\tabularnewline
DBI\_1.1.2 & Write data to an `*.sqlite` object & 05\_pull\_together\_sql.R\tabularnewline
\bottomrule
\end{longtable}

### Platform

The DataPLANT's DataHUB[^DataHUB] is a customized instance of GitLab[^GitLab], currently running under version 14.10.2, hosted and maintained by the DataPLANT node at Albert-Ludwigs-University Freiburg. Data is retrieved from the DataHUB via GitLab API version 4.  
After registration[^dpregister] with DataPLANT, users can share and access non-public ARCs via the DataHUB.
As explained in the `arcFinder`'s README, a GitLab private access token (PAT) needs to be generated within the DataHUB and provided to `arcFinder`.

## Checks and tests

Currently tested only under macOS Monterey 12.3.1 (x86_64-apple-darwin17.0, 64-bit) with software versions specified under [Dependencies](#dependencies).

## Deviation from the original concept

The originally proposed concept targeted an automated workflow for easier metadata-ingestion from previously published manuscripts into an the ISA model of an ARC.
As this workflow (a) targets a completely other "side" of the ARC and DataHUB environment and thus (b) comes with multiple additional and more complicated dependencies, it was omitted from the ARC-Finder presented here.

<!-- Footnotes -->

[^CEPLAS]: CEPLAS, <https://ceplas.eu>
[^DataPLANT]: DataPLANT, <https://nfdi4plants.de> 
[^dpregister]: DataPLANT registration, <https://register.nfdi4plants.org/>
[^DataHUB]: DataPLANT DataHUB, <https://git.nfdi4plants.org>
[^ARC]:  ARC specifications, <https://github.com/nfdi4plants/ARC-specification/>
[^ISA]: ISA Metadata Schema, <https://isa-tools.org/>
[^git]: Git, <https://git-scm.com/>
[^GitLab]: GitLab, <https://gitlab.com>
[^renv]: R package "renv", <https://rstudio.github.io/renv/>

<!-- Footnotes -->

# Scripts

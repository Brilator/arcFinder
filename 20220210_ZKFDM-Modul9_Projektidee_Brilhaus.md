
# CEPLAS project registry

## Idea

Collect and share high-level metadata (bibliographical metadata, project idea, nothing sensitive) of all projects going on in [CEPLAS](https://ceplas.eu) with and for CEPLAS members (only).

## Basis

- Developments in [DataPLANT](https://nfdi4plants.de)
  - Platform: [DataPLANT GitLab](https://gitlab.nfdi4plants.de/explore)
    - Restricted user group: CEPLAS members
  - Data structure: [ARC](https://github.com/nfdi4plants/ARC) (i.e. structured git repositories)
  - Metadata schema: [ISA](http://isa-tools.org) (serialized as ISA-tab)
    - selected ontologies to categorize contributor roles, study/experiment types and outputs

## Approach

### Data collection

1. Let CEPLAS volunteers describe their project in the ISA-tab isa.investigation.xlsx Excel workbook.
    - More GDPR safe alternative: build dummies based on published manuscripts. Could also be a nice use-case for a retrospective project data base.

2. Store data in ARCs on DataPLANT GitLab

### Data wrangling

3. Crawl ARCs via GitLab API
    - Get info from isa.investigation.xlsx only

4. Feed information into database (simple container or table)
    - bash / python / R

### Data dissemination

5. Build a locally running (double-safe) app or interactive doc (e.g. shiny doc in R) based on database that allows searching for values in specific or any fields of the isa investigation.

## Possible hurdles

1. Voluntary input required
2. Writing metadata in isa investigation is not really fun and we actually wanted to avoid asking people to do so.

## Reasoning
>
> - This is a quick fix project to gain use of the ARC as data structure
> - Without double-dipping for (meta)data

1. Why not other / simpler platform?
    - Collect metadata in persistent schema (ISA)
2. Isn't DataPLANT building this?
    - Yes, but bigger (scope and visibility) and more complicated
    - Not just looking at isa.investigation level.
    - Unsolved dependencies
        - Leveled permissions?
        - isa.api

<div style="page-break-after: always;"></div>

## Alternative

Automated publication crawler -> isa.investigation filler

<div style="page-break-after: always;"></div>
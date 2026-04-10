# DWBI Project – Wide World Importers (SSIS + SSAS + Power BI)

This repository contains my Data Warehousing & Business Intelligence coursework project, built using the Microsoft Wide World Importers (WWI) dataset.

## Overview
- Designed a **star schema** data warehouse (fact + dimensions)
- Built **SSIS ETL** packages to load data into staging and the data warehouse
- Created an **SSAS cube** for analytical querying
- Developed a **Power BI dashboard** for reporting and visualization

## Tech Stack / Tools
- SQL Server, T-SQL  
- SSIS (ETL)  
- SSAS (Cube)  
- Power BI  
- Dimensional Modeling (Star Schema)

## Repository Structure
- `ssis/` – SSIS Integration Services project and ETL packages (`.dtsx`, `.dtproj`)
- `ssas/` – SSAS cube project (`.dwproj`, `.cube`, `.dim`, `.dsv`)
- `powerbi/` – Power BI report (`.pbix`)
- `sql/` – SQL scripts (schema/queries)
- `diagrams/` – ERD / star schema diagrams (`.drawio`)
- `docs/` – assignment/report documents (if included)

## How to Open
### SSIS
Open the `.sln` file inside `ssis/` using Visual Studio with SQL Server Data Tools (SSDT).

### SSAS
Open the `.sln` file inside `ssas/` using Visual Studio with SSDT.

### Power BI
Open the `.pbix` file in `powerbi/` using Power BI Desktop.

## Notes
Build folders and machine-specific files (`bin/`, `obj/`, `.vs/`, `*.user`, `*.database`) are excluded from this repo.

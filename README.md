# Blood Donation Data Engineering Project

This project builds an end-to-end analytics pipeline for a blood donation domain using PostgreSQL, PowerShell-based raw data loading, and `dbt` for transformation, testing, snapshots, and documentation.

The repository is organized to support the full flow from raw operational-style CSV data to a curated dimensional model for analytics. It includes:

- raw table DDLs for source ingestion
- source data loading logic with change detection
- dbt staging models for cleaning and standardization
- dimensional and fact models for analytics
- snapshots for tracking selected entity changes over time
- schema tests and documentation files

## Project Goal

The main goal of this project is to transform raw blood donation system data into a clean analytics layer that can answer business questions such as:

- How many donations were collected over time?
- Which blood groups are most available or most requested?
- Which hospitals are receiving the highest number of requests?
- What is the testing outcome distribution across donors and dates?
- How does blood inventory change over time?

## Tech Stack

- `PostgreSQL` for source and transformed data storage
- `dbt` for transformations, tests, snapshots, and documentation
- `dbt_utils` package for generic tests
- `PowerShell` for incremental raw file loading
- `CSV` files as the raw input format

## Repository Structure

```text
Blood_donation/
|-- DDLs/
|   |-- *.sql
|-- demo_project/
|   |-- dbt_project.yml
|   |-- packages.yml
|   |-- macros/
|   |-- models/
|   |   |-- sources.yml
|   |   |-- staging/
|   |   `-- analytics/
|   |       |-- dimensions/
|   |       `-- facts/
|   `-- snapshots/
|-- scripts/
|   `-- load_incremental.ps1
|-- updated_scripts_for_source_data/
|   `-- *.csv
|-- logs/
|-- Miscellaneous/
`-- README.md
```

## Data Pipeline Overview

The pipeline follows a layered warehouse design.

### 1. Raw Layer

The `DDLs/` folder contains SQL scripts to create the raw source tables under the `raw` schema. These tables mirror incoming CSV files and store values mostly as text before transformation.

Raw entities currently modeled include:

- `donors`
- `donations`
- `blood_inventory`
- `blood_tests`
- `blood_type_compatibility`
- `donor_history`
- `hospitals`
- `recipients`
- `requests`
- `tasks`
- `technicians`
- `technician_tasks`

### 2. Raw Ingestion Layer

The script [load_incremental.ps1](./scripts/load_incremental.ps1) loads CSV files from `updated_scripts_for_source_data/` into the `raw` schema.

Key behaviors:

- prompts once for the PostgreSQL password
- scans all CSV files in the source data folder
- checks `raw.file_load_tracker` to identify changed files
- truncates and reloads only changed tables
- updates the tracker table with each file's last modified timestamp

This gives a lightweight file-based incremental ingestion process.

### 3. Staging Layer

The `demo_project/models/staging/` layer standardizes raw data into typed, cleaned, and analysis-ready tables in the `staging` schema.

Typical transformations in staging:

- casting text fields to numeric, boolean, and date types
- trimming whitespace
- standardizing case with `UPPER`, `LOWER`, and `INITCAP`
- converting invalid placeholder dates such as `'0000-00-00'` to `NULL`
- deriving operational flags like request status
- adding `stg_load_timestamp` for incremental downstream processing

Examples:

- `stg_donors.sql` cleans donor demographics and eligibility fields
- `stg_requests.sql` derives `request_status` based on `required_date`
- `stg_blood_donations.sql` standardizes donation records and blood group values
- `stg_blood_inventory.sql` normalizes storage and expiry fields

### 4. Analytics Layer

The `analytics` layer stores curated reporting models in the `analytics` schema.

It is divided into dimensions and facts.

#### Dimension Models

Located in `demo_project/models/analytics/dimensions/dim_models/`

- `dim_donors`
- `dim_hospitals`
- `dim_recipients`
- `dim_dates`

These provide descriptive context for reporting. For example:

- `dim_donors` contains donor attributes like name, blood group, eligibility, and location
- `dim_hospitals` contains hospital identity and classification fields
- `dim_recipients` contains recipient-level descriptive attributes
- `dim_dates` provides a reusable calendar table from `2020-01-01` to `2030-12-31`

#### Fact Models

Located in `demo_project/models/analytics/facts/fact_models/`

- `fact_blood_donations`
- `fact_blood_requests`
- `fact_blood_tests`
- `fact_blood_inventory`

These models are incremental and use `delete+insert` with business keys such as `donation_id`, `request_id`, `test_id`, and `inventory_id`.

They combine staging data with dimension keys to support reporting on:

- donation volume and status
- blood request urgency and fulfillment context
- test outcomes by donor and date
- current inventory state, quality, and expiry windows

### 5. Snapshot Layer

The `demo_project/snapshots/` folder tracks historical changes for selected entities using dbt snapshots.

Snapshot coverage includes:

- donors
- hospitals
- recipients


These use the `check` strategy to preserve historical versions when selected business attributes change.

## Data Model Summary

At a high level, the warehouse follows a star-schema style design:

- dimensions hold descriptive attributes
- facts hold measurable events or balances
- date keys connect event dates to the shared date dimension
- donor, hospital, and recipient identifiers link operational events to descriptive entities

Core analytical grains:

- one row per donation in `fact_blood_donations`
- one row per request in `fact_blood_requests`
- one row per test in `fact_blood_tests`
- one row per inventory record in `fact_blood_inventory`

## dbt Configuration

The dbt project lives inside `demo_project/`.

Important configuration from [dbt_project.yml](./demo_project/dbt_project.yml):

- project name: `demo_project`
- profile name: `demo_project`
- staging models materialize as `table` by default
- analytics models materialize as `table` by default
- individual staging models override this with `incremental`
- individual fact models override this with `incremental`

The project also depends on:

- `dbt-labs/dbt_utils`

defined in [packages.yml](./demo_project/packages.yml).

## Testing and Documentation

Schema YAML files define model descriptions, column descriptions, and tests across the project.

Test coverage includes:

- `not_null`
- `unique`
- `relationships`
- `accepted_values`
- `dbt_utils.expression_is_true`
- `dbt_utils.unique_combination_of_columns`
- `dbt_utils.equal_rowcount`

Documentation files are present for:

- staging models
- dimension models
- fact models

This makes the project suitable for `dbt docs generate` and `dbt docs serve`.

## Setup Instructions

### 1. Prerequisites

Install and configure:

- PostgreSQL
- `dbt-core`
- `dbt-postgres`
- PowerShell

You also need a valid dbt profile for `demo_project` in your local `profiles.yml`.

### 2. Create Raw Tables

Run the SQL scripts in `DDLs/` to create the raw tables in PostgreSQL.

You should also ensure the following exist:

- schema `raw`
- schema `staging`
- schema `analytics`
- schema `snapshots`
- table `raw.file_load_tracker`

### 3. Place Source CSV Files

Keep the source CSV files in:

```powershell
Blood_donation\updated_scripts_for_source_data\
```

### 4. Load Raw Data

From the project root, run:

```powershell
.\scripts\load_incremental.ps1
```

This loads changed files into the `raw` schema.

### 5. Install dbt Dependencies

```powershell
cd .\demo_project
dbt deps
```

### 6. Run dbt Models

```powershell
dbt run
```

### 7. Run Snapshots

```powershell
dbt snapshot
```

### 8. Run Tests

```powershell
dbt test
```

### 9. Generate Documentation

```powershell
dbt docs generate
dbt docs serve
```

## Recommended Execution Order

For a clean project run, use this sequence:

```powershell
.\scripts\load_incremental.ps1
cd .\demo_project
dbt deps
dbt run
dbt snapshot
dbt test
dbt docs generate
```

## Important Files

- [DDLs](./DDLs) contains raw table creation scripts
- [scripts/load_incremental.ps1](./scripts/load_incremental.ps1) performs CSV-to-Postgres loading
- [demo_project/models/sources.yml](./demo_project/models/sources.yml) defines raw source tables
- [demo_project/models/staging/schema.yml](./demo_project/models/staging/schema.yml) contains staging documentation and tests
- [demo_project/models/analytics/dimensions/dim_models](./demo_project/models/analytics/dimensions/dim_models) contains dimension models
- [demo_project/models/analytics/facts/fact_models](./demo_project/models/analytics/facts/fact_models) contains fact models
- [demo_project/snapshots](./demo_project/snapshots) contains dbt snapshots

## Example Analytical Use Cases

This model can support dashboards and SQL analysis for:

- total donations by day, month, hospital, or blood group
- active blood requests by urgency and hospital
- blood inventory nearing expiration
- donor eligibility and donor population by location
- positive vs. negative blood test trends
- recipient demand patterns by blood type

## Notes and Assumptions

- Raw CSV files are ignored in version control via `.gitignore`
- Staging and fact models rely on `stg_load_timestamp` to support incremental processing
- The project appears designed for PostgreSQL-specific SQL features such as `generate_series`
- The dbt profile configuration is not committed in this repository and must exist locally

## Future Improvements

Some useful next enhancements for this project would be:

- add a root SQL/bootstrap script to create all schemas and the file tracker table
- add seed data or sample datasets for easier onboarding
- add orchestration with Airflow or another scheduler
- extend tests for freshness and source-level quality checks
- add a diagram of lineage and the star schema

## Authoring Summary

This repository demonstrates a practical healthcare-oriented data engineering workflow:

1. ingest operational CSV data into PostgreSQL raw tables
2. standardize and validate source records in dbt staging models
3. build reusable dimensions and incremental fact tables
4. preserve historical changes using snapshots
5. test and document the warehouse for analytics consumption

It is a solid foundation for portfolio presentation, analytics reporting, and future orchestration work.

# NYC 311 SQL Analytics — CI/CD Pipeline

## Overview
This project demonstrates a **SQL-first analytics workflow** with a fully automated **CI/CD pipeline**.  
It validates analytical SQL against a real PostgreSQL instance on every code change, ensuring correctness, stability, and production readiness.

The focus is **not on dashboards or APIs**, but on **reliable analytics delivery** using disciplined data engineering practices.

---

## Problem Statement
Analytical SQL often breaks silently due to schema changes, logic errors, or unvalidated assumptions.  
This project addresses that risk by enforcing **automated validation of analytics SQL** before changes are merged.

---

## What This Project Does
- Builds analytical views on top of NYC 311 service request data
- Validates SQL logic automatically using GitHub Actions
- Fails CI if schemas, data loads, or analytics queries break
- Treats SQL as production code

---

## Dataset
**NYC 311 Service Requests (2010–Present)**  
https://www.kaggle.com/datasets/pablomonleon/311-service-requests-nyc
A small, representative **CSV sample** is committed for CI execution.  
The full dataset remains local-only and is not tracked in Git.

---

## Analytics Implemented
The project produces validated analytical views such as:
- Daily request volume trends
- Top complaint types
- Request status distribution

These represent the kind of metrics consumed by dashboards or downstream services.

---

## CI/CD Pipeline
On every pull request and push to `main`, the pipeline:

1. Lints SQL using **SQLFluff**
2. Starts a temporary **PostgreSQL** instance
3. Applies schema definitions
4. Loads sample data
5. Builds analytical views
6. Executes SQL-based smoke tests
7. Fails the build on any error

This ensures analytics logic is always executable and correct.

---

## Repository Structure

```
nyc-311-sql-cicd/
├── sql/
│ ├── 00_schema.sql
│ ├── 01_load.sql
│ ├── 02_views.sql
│ └── 03_smoke_tests.sql
├── scripts/
│ └── make_sample_csv.py
├── data/
│ ├── raw/ # local only (gitignored)
│ └── sample/ # committed sample for CI
├── .github/workflows/
│ └── ci.yml
└── README.md
```


---

## Local Usage (Optional)
Generate the sample CSV:
```bash
python scripts/make_sample_csv.py
```
---

## Technologies Used
- PostgreSQL
- SQL
- GitHub Actions
- SQLFluff
- Python (for sample generation only)

---

## Status
- ✅ CI/CD pipeline operational
- ✅ SQL validated against real database
- ✅ Ready for production-style analytics workflows
---



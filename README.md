# stackoverflow-case
## Project Goal
Modeling popular Stack Overflow topics with low response rate, using Google BigQuery public data.

## Execution Instructions
After cloning the repository locally, you need to configure the connection to BigQuery:
```
dbt init
```
Ensure that the connection is working properly:
```
dbt test
```
Apply the models to the database:
```
dbt build
```
To run only a specific part of the project:
```
dbt run --select "caminho\do\modelo"
```

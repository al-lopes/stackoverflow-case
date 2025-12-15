# stackoverflow-case
## Objetivo do Projeto
Modelar os tópicos populares do Stack Overflow com poucas respostas, utilizando os dados públicos do Google BigQuery.

## Instruções de execução
Após copiar o repositório localmente, é necessário configurar a ligação ao BigQuery:
```
dbt init
```
Garantir que a ligação está ok:
```
dbt test
```
Para aplicar os modelos na BD:
```
dbt build
```
Para aplicar apenas uma parte do projeto:
```
dbt run --select "caminho\do\modelo"
```

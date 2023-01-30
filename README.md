# Data Mart Building

## intoduction:
In this project, I focus on building a sales data mart for a company by extracting new and updated data from the AdventureWorks2019 (OLTP data) database, creating a star schema and load data to dimensions and fact tables after transforming the data, and finally applying full, incremental, and slow-changing dimension (SCD) loading.

#### Data Mart: is a subject-oriented database that is often a partitioned segment of an enterprise data warehouse.


## Data Source:
using AdventureWorks2014 (OLTP) from microsoft [source](https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2019.bak).

## steps:

1. Data Modeling by creating star schema for the data mart:

![star schema](https://github.com/alaahgag/data_mart_building/blob/77d9173ea5d99cabfca0427e3851ce9fe8143097/images/star%20schema.PNG)

2. Slowly Changing Dimension (SCD)

![SCD](https://github.com/alaahgag/data_mart_building/blob/77d9173ea5d99cabfca0427e3851ce9fe8143097/images/Dim%20Product%20ETL.PNG)

3. Full load to fact sales table

![Full load](https://github.com/alaahgag/data_mart_building/blob/77d9173ea5d99cabfca0427e3851ce9fe8143097/images/Fact%20Sales%20Full%20load.PNG)

4. Increamental load for new records updated to the source database. 

![increamental load](https://github.com/alaahgag/data_mart_building/blob/77d9173ea5d99cabfca0427e3851ce9fe8143097/images/Fact%20Sales%20incremental%20ETL.PNG)

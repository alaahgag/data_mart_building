use AdventureWorksDW2014_1
go 

if exists
	(select * from sys.foreign_keys 
	where name='fk_fact_sales_dim_date'
	and parent_object_id=object_id('fact_sales'))
	alter table fact_sales drop constraint fk_fact_sales_dim_date;

go


--Drop dim_product table if exists:
if exists(select * from sys.tables where name='dim_date' and type='U')
	drop table dim_date;

go


--create dim_date table:
create table dim_date(
date_key int not null identity(1,1),
full_date date not null,
calender_year date not null,
calender_quarter date not null,
calender_month_num date not null,
calender_month_name nvarchar(15) not null,

constraint pk_dim_date
primary key clustered (date_key)

);
go

--create foreign keys
if exists(select * from sys.tables where name='fact_sales')
	alter table fact_sales add constraint fk_fact_sales_dim_date
	foreign key (order_date_key)
	references dim_date(date_key);

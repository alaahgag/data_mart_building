use AdventureWorksDW2014_1;
go 

if exists
	(select * from sys.foreign_keys 
	where name='fk_fact_sales_dim_customer'
	and parent_object_id=object_id('fact_sales'))
	alter table fact_sales drop constraint fk_fact_sales_dim_customer;

go


--Drop dim_product table if exists:
if exists(select * from sys.tables where name='dim_customer' and type='U')
	drop table dim_customer;

go


--create dim_customer table:
create table dim_customer(
customer_key int not null identity(1,1),
customer_id int not null,
customer_name nvarchar(150),
address1 nvarchar(100),
address2 nvarchar(100),
city nvarchar(30),
phone nvarchar(25),
source_system_code tinyint not null,
start_date datetime not null DEFAULT (getdate()),
end_date datetime,
is_current tinyint not null	DEFAULT (1),

constraint pk_dim_customer
primary key clustered (customer_key)

);
go


--create foreign keys
if exists(select * from sys.tables where name='fact_sales')
	alter table fact_sales add constraint fk_fact_sales_dim_customer
	foreign key (customer_key)
	references dim_customer(customer_key);


--drop indexes:
if exists(select * from sys.indexes 
			where name='dim_customer_customer_id'
			and object_id=object_id('dim_customer'))
drop index dim_customer.dim_customer_customer_id;


if exists(select * from sys.indexes 
			where name='dim_customer_city'
			and object_id=object_id('dim_customer'))
drop index dim_customer.dim_customer_city;


--create indexes:
create index dim_customer_customer_id 
on dim_customer(customer_id);


create index dim_customer_city
on dim_customer(city);

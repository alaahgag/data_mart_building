use AdventureWorksDW2014_1;
go 

if exists
	(select * from sys.foreign_keys 
	where name='fk_fact_sales_dim_product'
	and parent_object_id=object_id('fact_sales'))
	alter table fact_sales drop constraint fk_fact_sales_dim_product;

go


--Drop dim_product table if exists:
if exists(select * from sys.tables where name='dim_product' and type='U')
	drop table dim_product;

go


--create dim_product table:
create table dim_product(
product_key int not null identity(1,1),
product_id int not null,
product_name nvarchar(50),
Product_description NVARCHAR(400),
product_subcategory nvarchar(50),
product_category nvarchar(50),
color nvarchar(15),
model_name nvarchar(50),
recorder_point smallint,
standard_cost money,
source_system_code tinyint not null,
start_date datetime not null DEFAULT (getdate()),
end_date datetime,
is_current tinyint not null	DEFAULT (1),

constraint pk_dim_product
primary key clustered (product_key)

);
go


--create foreign keys
if exists(select * from sys.tables where name='fact_sales')
	alter table fact_sales add constraint fk_fact_sales_dim_product
	foreign key (prodcut_key)
	references dim_product(product_key);


--drop indexes:
if exists(select * from sys.indexes 
			where name='dim_product_product_id'
			and object_id=object_id('dim_porduct'))
drop index dim_product.dim_product_product_id;


if exists(select * from sys.indexes 
			where name='dim_product_product_category'
			and object_id=object_id('dim_porduct'))
drop index dim_product.dim_product_product_category;


--create indexes:
create index dim_product_product_id 
on dim_product(product_id);


create index dim_product_product_category
on dim_product(product_category);
use AdventureWorksDW2014_1;
go

--drop fact_sales table:
if exists(select * from sys.tables where name='fact_sales')
	drop table fact_sales;

GO


--create fact_sales table:
create table fact_sales(
product_key int not null,
customer_key int not null,
territory_key int not null,
order_date_key int not null,
sales_order_id varchar(50) not null,
line_number int not null,
quantity int,
unit_price money,
unit_cost money,
tax_amount money,
freight money,
extended_sales money,
extended_cost money,
craeted_at datetime not null default (getdate()),
constraint pk_fact_sales
primary key clustered(sales_order_id,line_number),

constraint fk_fact_sales_dim_product
foreign key (product_key) references dim_product(product_key),
constraint fk_fact_sales_dim_customer
foreign key (customer_key) references dim_customer(customer_key),
constraint fk_fact_sales_dim_territory
foreign key (territory_key) references dim_territory(territory_key),
constraint fk_fact_sales_dim_date
foreign key (order_date_key) references dim_date(date_key),

);
go

--drop indexes:
if exists(select * from sys.indexes 
			where name='fact_sales_dim_product'
			and object_id=object_id('fact_sales'))
drop index fact_sales.fact_sales_dim_product;


if exists(select * from sys.indexes 
			where name='fact_sales_dim_customer'
			and object_id=object_id('dim_customer'))
drop index fact_sales.fact_sales_dim_customer;


if exists(select * from sys.indexes 
			where name='fact_sales_dim_territory'
			and object_id=object_id('dim_territory'))
drop index fact_sales.fact_sales_dim_territory;


if exists(select * from sys.indexes 
			where name='fact_sales_dim_date'
			and object_id=object_id('dim_date'))
drop index fact_sales.fact_sales_dim_date;


--create indexes:
create index fact_sales_dim_product
on fact_sales(product_key);


create index fact_sales_dim_customer
on fact_sales(customer_key);

create index fact_sales_dim_territory
on fact_sales(territory_key);

create index fact_sales_dim_date
on fact_sales(order_date_key);
use AdventureWorksDW2014_1;
go 

if exists
	(select * from sys.foreign_keys 
	where name='fk_fact_sales_dim_territory'
	and parent_object_id=object_id('fact_sales'))
	alter table fact_sales drop constraint fk_fact_sales_dim_territory;

go


--Drop dim_product table if exists:
if exists(select * from sys.tables where name='dim_territory' and type='U')
	drop table dim_territory;

go


--create dim_territory table:
create table dim_territory(
territory_key int not null identity(1,1),
territory_id int not null,
territory_name nvarchar(50),
territory_country nvarchar(400),
territory_group nvarchar(50),
source_system_code tinyint not null,
start_date datetime not null DEFAULT (getdate()),
end_date datetime,
is_current tinyint not null	DEFAULT (1),

constraint pk_dim_territory
primary key clustered (territory_key)

);
go

SET IDENTITY_INSERT dim_territory ON

INSERT INTO dim_territory
            (territory_key,
             territory_id,
             territory_name,
             territory_country,
             territory_group,
             source_system_code,
             start_date,
             end_date,
             is_current)
VALUES     (0,
            0,
            'Unknown',
            'Unknown',
            'Unknown',
            0,
            '1900-01-01',
            NULL,
            1)

SET IDENTITY_INSERT dim_territory OFF


--create foreign keys
if exists(select * from sys.tables where name='fact_sales')
	alter table fact_sales add constraint fk_fact_sales_dim_territory
	foreign key (territory_key)
	references dim_territory(territory_key);


--drop indexes:
if exists(select * from sys.indexes 
			where name='dim_territory_territory_id'
			and object_id=object_id('dim_territory'))
drop index dim_territory.dim_territory_territory_id;


--create indexes:
create index dim_territory_territory_id
on dim_territory(territory_id);


select * from dim_territory 
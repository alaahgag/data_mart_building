use AdventureWorksDW2014_1;
go 


if exists(select * from sys.tables where name = 'meta_control_table')
	drop table meta_control_table;

go


create table meta_control_table(
id int not null identity(1,1),
source_table nvarchar(50) not null,
last_load_date datetime

);
go

insert into meta_control_table(source_table,last_load_date)
values('sales order header','1900-01-01');

select * from meta_control_table

select * from fact_sales
order by craeted_at desc



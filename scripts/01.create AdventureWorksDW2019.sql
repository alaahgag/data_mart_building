use master
go

if exists(select * from sys.databases where name= 'AdventureWorksDW2019_1')
	drop database AdventureWorksDW2019_1

GO 

create database AdventureWorksDW2019_1
go

/*
	8th sheet of MS SQL Server Masterclass
	Create Widows user login
*/
--------------------------------------------------------------------------------------
--Create Windows user login with script
Create Login [sql\guestuser] from windows
with default_database = [SchoolManagementDb]

Go

use [SchoolManagementDb]
create user guestuser for login [sql\guestuser];
exec sp_addrolemember 'db_datareader', 'guestuser'

---------------------------------------------------------------------------------------
--Create Sql user login with script
Create login [Sahilkrgupta5] with password = 'Sahil@54321',
default_database = [SchoolManagementDb]

Go

use [SchoolManagementDb]
create user [Sahilkrgupta5] for login [Sahilkrgupta5];
exec sp_addrolemember 'db_datareader', 'guestuser'
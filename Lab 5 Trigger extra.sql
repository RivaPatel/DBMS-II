CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)
	
CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
	EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

--1)Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on 
--the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", 
--"Employee record deleted"

 CREATE TRIGGER tr_EMPLOYEEDETAILS_Insert
ON EMPLOYEEDETAILS
AFTER INSERT
AS 
BEGIN
	PRINT 'Employee is Inserted' ;
END

DROP TRIGGER tr_EMPLOYEEDETAILS_Insert


CREATE TRIGGER tr_EMPLOYEEDETAILS_Update
ON EMPLOYEEDETAILS
AFTER Update
AS 
BEGIN
	PRINT 'Employee is Updated' ;
END

DROP TRIGGER tr_EMPLOYEEDETAILS_Update


CREATE TRIGGER tr_EMPLOYEEDETAILS_Delete
ON EMPLOYEEDETAILS
AFTER DELETE
AS 
BEGIN
	PRINT 'Employee is Deleted' ;
END

DROP TRIGGER tr_EMPLOYEEDETAILS_Delete


--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.
CREATE TRIGGER tr_Employee_after_Insert
ON EmployeeLogs
After insert
as
begin
	Declare @EmpID int;
	Declare @EmpName varchar(100);

	select @EmpID = EmployeeID from inserted
	Select @EmpName = EmployeeName from inserted

	Insert into EmployeeLogs
	values(@EmpID, @EmpName, 'Insert', getdate())

end

DROP TRIGGER tr_Employee_after_Insert
 

CREATE TRIGGER tr_Employee_after_Update
ON EmployeeDetails
After Update
as
begin
	Declare @EmpID int;
	Declare @EmpName varchar(100);

	select @EmpID = EmployeeID from inserted
	Select @EmpName = EmployeeName from inserted

	Insert into EmployeeLogs
	values(@EmpID, @EmpName, 'Update', getdate())

end

DROP TRIGGER tr_Employee_after_Update

CREATE TRIGGER tr_Employee_after_Delete
ON EmployeeDetails
After Delete
as
begin
	Declare @EmpID int;
	Declare @EmpName varchar(100);

	select @EmpID = EmployeeID from inserted
	Select @EmpName = EmployeeName from inserted

	Insert into EmployeeLogs
	values(@EmpID, @EmpName, 'Delete', getdate())

end

DROP TRIGGER tr_Employee_after_Delete

--3)	Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and 
--update a bonus column in the EmployeeDetails table.
CREATE OR ALTER TRIGGER tr_Employee_Bonus
On EmployeeDetails
After Insert
as
begin
	declare @empId int;
	select @empId= EmployeeID from inserted
	
	Update EmployeeDetails
	set Salary = Salary + Salary*0.1
	where EmployeeID = @empId
end

DROP TRIGGER tr_Employee_Bonus


--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.
Create or alter trigger tr_Update_JoiningDate
on employeedetails
After Insert
as
begin
	declare @empId int;
	declare @JoiningDate datetime;
	select @empId= EmployeeID from inserted;
	select @JoiningDate = JoiningDate from inserted

	if @JoiningDate IS Null
		begin
			Update EMPLOYEEDETAILS
			set JoiningDate = getdate()
			where EmployeeID = @empId 
		end

end

DROP trigger tr_Update_JoiningDate


--5)	Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)
Create or alter trigger tr_Valid_ContactNO
on employeeDetails
After Insert,Update
as
begin
	declare @empId int;
	declare @Contact datetime;
	select @empId= EmployeeID from inserted;
	select @Contact = ContactNo from inserted

	if Len(@Contact)!=10
		print('ContactNo is invalid')
		
end

DROP trigger tr_Valid_ContactNO

DROP TRIGGER TR_VALID_CONTACTNO 
DROP TRIGGER TR_DHARASHVI 
DROP TRIGGER TR_BHOLU
DROP T
------------------------------------------------------------------------------------------------------------------

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);


--1.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations
--performed on the Movies table into MoviesLog.
Create or alter trigger tr_Insteadof_insert_Movie
on Movies
instead of Insert
as
begin
	Declare @movieId int;
	Declare @title varchar(100);

	select @movieId = movieId from inserted
	Select @title = movietitle from inserted

	Insert into MoviesLog
	values(@movieId, @title, 'Insert', getdate())

end

DROP trigger tr_Insteadof_insert_Movie

Create or alter trigger tr_Insteadof_insert_Movie
on Movies
instead of Update
as
begin
	Declare @movieId int;
	Declare @title varchar(100);

	select @movieId = movieId from inserted
	Select @title = movietitle from inserted

	Insert into MoviesLog
	values(@movieId, @title, 'Update', getdate())

end

DROP  trigger tr_Insteadof_insert_Movie

Create or alter trigger tr_Insteadof_insert_Movie
on Movies
instead of Delete
as
begin
	Declare @movieId int;
	Declare @title varchar(100);

	select @movieId = movieId from inserted
	Select @title = movietitle from inserted

	Insert into MoviesLog
	values(@movieId, @title, 'Delete', getdate())

end

DROP trigger tr_Insteadof_insert_Movie

--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
Create or alter trigger tr_Insteadof_insert_Movie
on Movies
instead of Insert
as
begin
	INSERT INTO MoviesLogs (MovieID, MovieTitle,  ReleaseYear,Genre, Rating,duration)
        SELECT MovieID, MovieTitle, ReleaseYear,Genre, Rating,duration
        FROM inserted
		where Rating>5.5;

end

DROP trigger tr_Insteadof_insert_Movie

--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.
Create or alter trigger tr_Insteadof_insert_Movie_duplicate
on Movies
instead of Insert
as
begin
	INSERT INTO Movies (MovieID, MovieTitle,  ReleaseYear,Genre, Rating,duration)
        SELECT MovieID, MovieTitle, ReleaseYear,Genre, Rating,duration
        FROM inserted
		where MovieTitle Not In (Select MovieTitle from inserted);

end

DROP trigger tr_Insteadof_insert_Movie_duplicate

--4.	Create trigger that prevents to insert pre-release movies.
Create or alter trigger tr_Insteadof_insert_Movie_PreRelease
on Movies
instead of Insert
as
begin
	INSERT INTO Movies (MovieID, MovieTitle,  ReleaseYear,Genre, Rating,duration)
        SELECT MovieID, MovieTitle, ReleaseYear,Genre, Rating,duration
        FROM inserted
		where Year(ReleaseYear)>Year(GetDate());

end

DROP trigger tr_Insteadof_insert_Movie_PreRelease

--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.
Create or alter trigger tr_Insteadof_insert_Movie_PreRelease
on Movies
instead of Insert
as
begin
	INSERT INTO Movies (MovieID, MovieTitle,  ReleaseYear,Genre, Rating,duration)
        SELECT MovieID, MovieTitle, ReleaseYear,Genre, Rating,duration
        FROM inserted
		where Duration>120;

end

DROP  trigger tr_Insteadof_insert_Movie_PreRelease
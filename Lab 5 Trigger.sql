-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);


-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
 
 );


 
--LAB 5

--Part – A

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display 
--a message “Record is Affected.” 
CREATE TRIGGER tr_PersonInfo
ON PersonInfo
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	PRINT 'Record is Affected' ;
END

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, 
--log all operations performed on the person table into PersonLog.
CREATE TRIGGER tr_Person_after_Insert
ON PersonInfo
After insert
as
begin
	Declare @PersonID int;
	Declare @PersonName varchar(100);

	select @PersonID = PersonID from inserted
	Select @PersonName = PersonName from inserted

	Insert into PersonLog
	values(@PersonID, @PersonName, 'Insert', getdate())

end

CREATE TRIGGER tr_Person_after_Update
ON PersonInfo
After Update
as
begin
	Declare @PersonID int;
	Declare @PersonName varchar(100);

	select @PersonID = PersonID from inserted
	Select @PersonName = PersonName from inserted

	Insert into PersonLog
	values(@PersonID, @PersonName, 'Update', getdate())

end

CREATE TRIGGER tr_Person_after_Delete
ON PersonInfo
After Delete
as
begin
	Declare @PersonID int;
	Declare @PersonName varchar(100);

	select @PersonID = PersonID from deleted
	Select @PersonName = PersonName from deleted

	Insert into PersonLog
	values(@PersonID, @PersonName, 'Delete', getdate())

end


--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 

CREATE TRIGGER TR_PERSON_INSTEAOF_INSERT
ON PERSONINFO
INSTEAD OF INSERT
AS 
BEGIN
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(100);

	 SELECT @PERSONID = PERSONID FROM INSERTED;
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED ; 

	 INSERT INTO PersonLog (PersonID , PersonName, Operation , UpdateDate)
	 VALUES (@PERSONID , @PERSONNAME , 'INSERT' , GETDATE())
END;

CREATE TRIGGER TR_PERSON_INSTEAOF_UPDATE
ON PERSONINFO
INSTEAD OF UPDATE
AS 
BEGIN
     DECLARE @PERSONID INT;
	 DECLARE @PERSONNAME VARCHAR(100);

	 SELECT @PERSONID = PERSONID FROM INSERTED;
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED ; 

	 INSERT INTO PersonLog (PersonID , PersonName, Operation , UpdateDate)
	 VALUES (@PERSONID , @PERSONNAME , 'INSERT' , GETDATE())
END;

CREATE TRIGGER TR_PERSON_INSTEAOF_DELETE
ON PERSONINFO
INSTEAD OF DELETE
AS 
BEGIN
     DECLARE @PERSONID INT;


--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into 
--uppercase whenever the record is inserted.
CREATE TRIGGER tr_Person_in_Uppercase
ON PersonInfo
After insert
as
begin
	Declare @PersonID int;
	Declare @PersonName varchar(100);

	select @PersonID = upper(PersonID) from inserted
	Select @PersonName = upper(PersonName) from inserted

	Insert into PersonLog
	values(@PersonID, @PersonName, 'Insert', getdate())

end

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.
--6. Create trigger that prevent Age below 18 years.

--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update 
--that age in Person table.
CREATE TRIGGER tr_Person_Age_Calculate_and_Update
ON PersonInfo
After Insert
as
begin
	Declare @PersonID int;
	select @PersonID = PersonID from inserted
	Update PersonInfo
	Set Age = Datediff(YEAR, BirthDate, getdate())
	where PersonID in (select PersonID from inserted)
end


--8. Create a Trigger to Limit Salary Decrease by a 10%.
CREATE TRIGGER tr_Person_Salary_decrement
ON PersonInfo
After Insert
as
begin
	declare @PersonId int;
	select @PersonId= PersonId from inserted

	Update PersonInfo
	Set Salary = salary- (salary*0.1)
	where PersonID = @PersonId

	declare @newSalary int;
	declare @oldSalary int;

	select @newSalary = Salary from inserted
	select @oldSalary = Salary from deleted

	if @newSalary < @oldSalary * 0.9
		Begin 
			Update PersonInfo
			set Salary = @oldSalary
			where PersonID = @PersonId
		end

end

--Part – C 
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL 
--during an INSERT.
Create trigger tr_Person_JoiningDate
on PersonInfo
After Insert
as
begin
	declare @PersonId int;
	declare @JoiningDate datetime;
	select @PersonId= PersonId from inserted;
	select @JoiningDate = JoiningDate from inserted

	if @JoiningDate IS Null
		begin
			Update PersonInfo
			set JoiningDate = getdate()
			where PersonID = @PersonId 
		end

end 

--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints 
--‘Record deleted successfully from PersonLog’.

CREATE TRIGGER tr_Personlog_Delete
ON PersonLog
After Delete
as
begin
	Print 'Record deleted successfully from PersonLog'
end

	 DECLARE @PERSONNAME VARCHAR(100);

	 SELECT @PERSONID = PERSONID FROM INSERTED;
	 SELECT @PERSONNAME = PERSONNAME FROM INSERTED ; 

	 INSERT INTO PersonLog (PersonID , PersonName, Operation , UpdateDate)
	 VALUES (@PERSONID , @PERSONNAME , 'INSERT' , GETDATE())
END;

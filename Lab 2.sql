USE CSE_B5_393 

-- Create Department Table
CREATE TABLE Department (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
DesignationID INT PRIMARY KEY,
DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
PersonID INT PRIMARY KEY IDENTITY(101,1),
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
Salary DECIMAL(8, 2) NOT NULL,
JoiningDate DATETIME NOT NULL,
DepartmentID INT NULL,
DesignationID INT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);


SELECT * FROM Department;
SELECT * FROM Designation;
SELECT * FROM Person;


----------------------------------PART - A-------------------------------------------------------------------------

-- 1. Department, Designation & Person Table’s INSERT Procedure
CREATE OR ALTER PROCEDURE InsertDepartment (@DepartmentID INT, @DepartmentName VARCHAR(100))
AS
INSERT INTO Department (DepartmentID, DepartmentName) VALUES (@DepartmentID, @DepartmentName);

CREATE OR ALTER PROCEDURE InsertDesignation (@DesignationID INT, @DesignationName VARCHAR(100))
AS
INSERT INTO Designation (DesignationID, DesignationName) VALUES (@DesignationID, @DesignationName);

CREATE OR ALTER PROCEDURE InsertPerson (@PersonID INT, @FirstName VARCHAR(100), @LastName VARCHAR(100), @Salary DECIMAL(8,2), @JoiningDate DATETIME, @DepartmentID INT, @DesignationID INT)
AS
INSERT INTO Person (PersonID, FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID) VALUES (@PersonID, @FirstName, @LastName, @Salary, @JoiningDate, @DepartmentID, @DesignationID);


-- Insert data into the Department table using the stored procedure
EXEC InsertDepartment @DepartmentID = 1, @DepartmentName = 'Admin';
EXEC InsertDepartment @DepartmentID = 2, @DepartmentName = 'IT';
EXEC InsertDepartment @DepartmentID = 3, @DepartmentName = 'HR';
EXEC InsertDepartment @DepartmentID = 4, @DepartmentName = 'Account';

-- Insert data into the Designation table using the stored procedure
EXEC InsertDesignation @DesignationID = 11, @DesignationName = 'Jobber';
EXEC InsertDesignation @DesignationID = 12, @DesignationName = 'Welder';
EXEC InsertDesignation @DesignationID = 13, @DesignationName = 'Clerk';
EXEC InsertDesignation @DesignationID = 14, @DesignationName = 'Manager';
EXEC InsertDesignation @DesignationID = 15, @DesignationName = 'CEO';

-- Insert data into the Person table using the stored procedure
EXEC InsertPerson @PersonID = 101, @FirstName = 'Rahul', @LastName = 'Anshu', @Salary = 56000, @JoiningDate = '1990-01-01', @DepartmentID = 1, @DesignationID = 12;
EXEC InsertPerson @PersonID = 102, @FirstName = 'Hardik', @LastName = 'Hinsu', @Salary = 18000, @JoiningDate = '1990-09-25', @DepartmentID = 2, @DesignationID = 11;
EXEC InsertPerson @PersonID = 103, @FirstName = 'Bhavin', @LastName = 'Kamani', @Salary = 25000, @JoiningDate = '1991-05-14', @DepartmentID = NULL, @DesignationID = 11;
EXEC InsertPerson @PersonID = 104, @FirstName = 'Bhoomi', @LastName = 'Patel', @Salary = 39000, @JoiningDate = '2014-02-20', @DepartmentID = 1, @DesignationID = 13;
EXEC InsertPerson @PersonID = 105, @FirstName = 'Rohit', @LastName = 'Rajgor', @Salary = 17000, @JoiningDate = '1990-07-23', @DepartmentID


-- Procedure to update the Department table
CREATE PROCEDURE UpdateDepartment (@DepartmentID INT, @NewDepartmentName VARCHAR(100))
AS
BEGIN
    UPDATE Department
    SET DepartmentName = @NewDepartmentName
    WHERE DepartmentID = @DepartmentID;
END;

-- Procedure to update the Designation table
CREATE PROCEDURE UpdateDesignation (@DesignationID INT, @NewDesignationName VARCHAR(100))
AS
BEGIN
    UPDATE Designation
    SET DesignationName = @NewDesignationName
    WHERE DesignationID = @DesignationID;
END;

-- Procedure to update the Person table
CREATE PROCEDURE UpdatePerson (@PersonID INT, @NewFirstName VARCHAR(100), @NewLastName VARCHAR(100), @NewSalary DECIMAL(8,2), @NewDepartmentID INT, @NewDesignationID INT)
AS
BEGIN
    UPDATE Person
    SET FirstName = @NewFirstName,
        LastName = @NewLastName,
        Salary = @NewSalary,
        DepartmentID = @NewDepartmentID,
        DesignationID = @NewDesignationID
    WHERE PersonID = @PersonID;
END;


-- Procedure to delete from the Department table
CREATE PROCEDURE DeleteDepartment (@DepartmentID INT)
AS
BEGIN
    DELETE FROM Department
    WHERE DepartmentID = @DepartmentID;
END;

-- Procedure to delete from the Designation table
CREATE PROCEDURE DeleteDesignation (@DesignationID INT)
AS
BEGIN
    DELETE FROM Designation
    WHERE DesignationID = @DesignationID;
END;

-- Procedure to delete from the Person table
CREATE PROCEDURE DeletePerson (@PersonID INT)
AS
BEGIN
    DELETE FROM Person
    WHERE PersonID = @PersonID;
END;


-- 2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY Procedure
CREATE OR ALTER PROCEDURE SelectDepartmentByID (@DepartmentID INT)
AS
SELECT * FROM Department WHERE DepartmentID = @DepartmentID;

CREATE OR ALTER PROCEDURE SelectDesignationByID (@DesignationID INT)
AS
SELECT * FROM Designation WHERE DesignationID = @DesignationID;

CREATE OR ALTER PROCEDURE SelectPersonByID (@PersonID INT)
AS
SELECT * FROM Person WHERE PersonID = @PersonID;


-- 3. Select with join based on foreign keys
CREATE OR ALTER PROCEDURE SelectPersonDetails
AS
SELECT p.PersonID, p.FirstName, p.LastName, p.Salary, p.JoiningDate, d.DepartmentName, ds.DesignationName
FROM Person p
LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
LEFT JOIN Designation ds ON p.DesignationID = ds.DesignationID;


-- 4. Create a Procedure that shows details of the first 3 persons
CREATE OR ALTER PROCEDURE GetFirstThreePersons
AS
SELECT TOP 3 * FROM Person;



----------------------------------PART - B-------------------------------------------------------------------------


-- 5. Create a Procedure that takes the department name as input and returns all workers in that department
CREATE PROCEDURE GetWorkersByDepartment (@DepartmentName VARCHAR(100))
AS
SELECT p.FirstName, p.LastName, p.Salary, d.DepartmentName
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = @DepartmentName;

-- 6. Create Procedure to fetch workers by department and designation
CREATE PROCEDURE GetWorkersByDeptAndDesignation (@DepartmentName VARCHAR(100), @DesignationName VARCHAR(100))
AS
SELECT p.FirstName, p.Salary, p.JoiningDate, d.DepartmentName
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
JOIN Designation ds ON p.DesignationID = ds.DesignationID
WHERE d.DepartmentName = @DepartmentName AND ds.DesignationName = @DesignationName;

-- 7. Create Procedure to fetch all worker details by their first name
CREATE PROCEDURE GetWorkerDetailsByFirstName (@FirstName VARCHAR(100))
AS
SELECT p.*, d.DepartmentName, ds.DesignationName
FROM Person p
LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
LEFT JOIN Designation ds ON p.DesignationID = ds.DesignationID
WHERE p.FirstName = @FirstName;

-- 8. Create Procedure for department-wise max, min & total salaries
CREATE PROCEDURE DepartmentWiseSalaryStats
AS
SELECT d.DepartmentName, MAX(p.Salary) AS MaxSalary, MIN(p.Salary) AS MinSalary, SUM(p.Salary) AS TotalSalary
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- 9. Create Procedure for designation-wise average & total salaries
CREATE PROCEDURE DesignationWiseSalaryStats
AS
SELECT ds.DesignationName, AVG(p.Salary) AS AvgSalary, SUM(p.Salary) AS TotalSalary
FROM Person p
JOIN Designation ds ON p.DesignationID = ds.DesignationID
GROUP BY ds.DesignationName;

-- 10. Create Procedure to Accept Department Name and Return Person Count
CREATE PROCEDURE GetPersonCountByDepartment (@DepartmentName VARCHAR(100))
AS
SELECT COUNT(*) AS PersonCount
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = @DepartmentName;

-- 11. Create a Procedure to fetch workers with salary greater than input
CREATE PROCEDURE GetWorkersWithSalaryGreaterThan (@SalaryValue DECIMAL(8,2))
AS
SELECT p.*, d.DepartmentName, ds.DesignationName
FROM Person p
LEFT JOIN Department d ON p.DepartmentID = d.DepartmentID
LEFT JOIN Designation ds ON p.DesignationID = ds.DesignationID
WHERE p.Salary > @SalaryValue;

-- 12. Create a Procedure to find departments with the highest total salary
CREATE PROCEDURE GetDepartmentWithHighestSalary
AS
SELECT TOP 1 d.DepartmentName, SUM(p.Salary) AS TotalSalary
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalSalary DESC;

-- 13. Create a Procedure to list workers by designation and joined in the last 10 years
CREATE PROCEDURE GetRecentWorkersByDesignation (@DesignationName VARCHAR(100))
AS
SELECT p.*, d.DepartmentName
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
JOIN Designation ds ON p.DesignationID = ds.DesignationID
WHERE ds.DesignationName = @DesignationName AND p.JoiningDate >= DATEADD(YEAR, -10, GETDATE());

-- 14. Create Procedure to count workers in each department without a designation
CREATE PROCEDURE CountWorkersWithoutDesignation
AS
SELECT d.DepartmentName, COUNT(*) AS WorkerCount
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
WHERE p.DesignationID IS NULL
GROUP BY d.DepartmentName;

-- 15. Create Procedure to retrieve workers in departments with average salary > 12000
CREATE PROCEDURE GetWorkersInHighSalaryDepartments
AS
SELECT p.*, d.DepartmentName
FROM Person p
JOIN Department d ON p.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IN (
    SELECT DepartmentID
    FROM Person
    GROUP BY DepartmentID
    HAVING AVG(Salary) > 12000
);


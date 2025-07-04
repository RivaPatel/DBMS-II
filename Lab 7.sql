CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(250) NOT NULL,
    Email VARCHAR(50) UNIQUE
);

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT,
    Order_date DATE NOT NULL,
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);


----------------Part � A---------------------


---------------1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

BEGIN TRY
	DECLARE @NUM1 INT = 12, @NUM2 INT = 0, @RESULT INT;
	SET @RESULT = @NUM1 / @NUM2;
END TRY
BEGIN CATCH
	PRINT 'Error occurs that is - Divide by Zero error.';
END CATCH;

---------------2. Try to convert string to integer and handle the error using try�catch block.

BEGIN TRY
	DECLARE @STRINGVALUE VARCHAR(10) = 'ABC';
	DECLARE @INTVALUE INT;
	SET @INTVALUE = CAST(@STRINGVALUE AS INT);
END TRY
BEGIN CATCH
	PRINT 'Error : Unable to convert string to integer.';
END CATCH;

------------3. Create a procedure that prints the sum of two numbers: 
-----------take both numbers as integer & handle exception with all error functions if any one enters string value in 
--------numbers otherwise print result.
CREATE PROCEDURE PR_CALCULATION_SumWithErrorHandaling
	@NUM1 VARCHAR(50),
	@NUM2 VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @INTNUM1 INT = CAST(@NUM1 AS INT);
		DECLARE @INTNUM2 INT = CAST(@NUM2 AS INT);
		PRINT 'Sum is : '+CAST(@INTNUM1 + @INTNUM2 AS VARCHAR(50));
	END TRY
		BEGIN CATCH
		PRINT 'ERROR NUMBER: '+ CAST(ERROR_NUMBER() AS VARCHAR(10));
		PRINT 'ERROR SEVERITY: '+ CAST(ERROR_SEVERITY() AS VARCHAR(10));
		PRINT 'ERROR STATE: '+ CAST(ERROR_STATE() AS VARCHAR(10));
		PRINT 'ERROR MESSAGE: '+ CAST(ERROR_MESSAGE() AS VARCHAR(10));
	END CATCH
END 

EXEC PR_CALCULATION_SumWithErrorHandaling '2','ABC'
EXEC PR_CALCULATION_SumWithErrorHandaling '2',4

------4. Handle a Primary Key Violation while inserting data into customers table and 
------print the error details such as the error message, error number, severity, and state.

BEGIN TRY
	INSERT INTO Customers(Customer_id,Customer_Name,Email) 
	VALUES (10000, 'RIVA', 'RIVA1575@GMAIL.COM');
END TRY
BEGIN CATCH
	PRINT 'Primary Key Violation Error';
	PRINT 'ERROR NUMBER: '+ CAST(ERROR_NUMBER() AS VARCHAR(10));
	PRINT 'ERROR SEVERITY: '+ CAST(ERROR_SEVERITY() AS VARCHAR(10));
	PRINT 'ERROR STATE: '+ CAST(ERROR_STATE() AS VARCHAR(10));
	PRINT 'ERROR MESSAGE: '+ CAST(ERROR_MESSAGE() AS VARCHAR(10));
END CATCH

-----5. Throw custom exception using stored procedure which accepts Customer_id as input & 
-----that throws Error like no Customer_id is available in database.

CREATE PROCEDURE PR_CheckCustomerExists
    @Customer_id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @Customer_id)
    BEGIN
        THROW 50001, 'Error: No Customer_id available in the database.', 1;
    END
    ELSE
    BEGIN
        PRINT 'Customer Exists!';
    END
END;

PR_CheckCustomerExists 34;

--Part � B
------6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error
--message.
BEGIN TRY
    INSERT INTO Orders (Order_id, Customer_id, Order_date)
    VALUES (101, 999, '2025-02-11'); 
END TRY
BEGIN CATCH
    PRINT 'Error: Foreign Key Violation. Customer_id does not exist.';
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;

--7. Throw custom exception that throws error if the data is invalid.

CREATE OR ALTER PROCEDURE ValidateCustomerData
    @Customer_id INT
AS
BEGIN
    IF @Customer_id < 0
    BEGIN
        THROW 50002, 'Invalid data', 1;
    END
    ELSE
    BEGIN
        PRINT 'Valid data. Proceeding...';
    END
END

EXEC ValidateCustomerData 1

--8. Create a Procedure to Update Customer�s Email with Error Handling.

CREATE OR ALTER PROCEDURE PR_UpdateCustomerEmail
    @Customer_id INT,
    @NewEmail NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        UPDATE Customers
        SET Email = @NewEmail
        WHERE Customer_id = @Customer_id;
    END TRY
    BEGIN CATCH
        PRINT 'Error: Unable to update email.';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC PR_UpdateCustomerEmail 10, 'newemail@example.com';

	
--Part � C

----9. Create a procedure which prints the error message that �The Customer_id is already taken. Try anotherone�.

CREATE PROCEDURE PR_CheckDuplicateCustomerId
    @Customer_id INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @Customer_id)
    BEGIN
        PRINT 'The Customer_id is already taken.';
    END
    ELSE
    BEGIN
        PRINT 'Customer_id is available.';
    END
END;

EXEC PR_CheckDuplicateCustomerId 1;

--10. Handle Duplicate Email Insertion in Customers Table.

CREATE PROCEDURE PR_DublicateEmail
    @NewEmail NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
      IF EXISTS (SELECT 1 FROM Customers WHERE Email = @NewEmail)
    BEGIN
        PRINT 'The email is inserted.';
    END
    END TRY
    BEGIN CATCH
        PRINT 'Error: Dublicate email inserted';
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Message: ' + ERROR_MESSAGE();
    END CATCH;
END;

EXEC PR_DublicateEmail 'newemail@example.com';

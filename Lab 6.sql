USE CSE_3B_422;

-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);


-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);

SELECT*FROM PRODUCTS;

----------------------------------------------Part - A---------------------------------------------------------------------------------------------------------------


---1. Create a cursor Product_Cursor to fetch all the rows from a products table.
DECLARE 
	@Product_id INT ,
	@Product_Name VARCHAR(250), 
	@Price DECIMAL(10,2)
DECLARE Product_Cursor CURSOR
FOR SELECT 
	Product_id ,
	Product_Name, 
	Price
FROM
	Products;

open  Product_Cursor;

FETCH NEXT FROM  Product_Cursor INTO
	@Product_id ,
	@Product_Name, 
	@Price;

WHILE @@FETCH_STATUS = 0
BEGIN 
	--SELECT 
	PRINT CAST(@Product_id AS VARCHAR)+'-'+@Product_Name+'-'+ CAST(@Price AS VARCHAR);
	FETCH NEXT FROM Product_Cursor INTO 	@Product_id ,@Product_Name, @Price
END

CLOSE Product_Cursor

DEALLOCATE Product_Cursor

---2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)
DECLARE 
	@Product_id INT ,
	@Product_Name VARCHAR(250)
DECLARE Product_Cursor CURSOR
FOR SELECT 
	Product_id ,
	Product_Name 
	
FROM
	Products;

open  Product_Cursor;

FETCH NEXT FROM  Product_Cursor INTO
	@Product_id ,
	@Product_Name;

WHILE @@FETCH_STATUS = 0
BEGIN 
	--SELECT 
	PRINT CAST(@Product_id AS VARCHAR)+'_'+@Product_Name;
	FETCH NEXT FROM Product_Cursor INTO 	@Product_id ,@Product_Name
END

CLOSE Product_Cursor

DEALLOCATE Product_Cursor

---3. Create a Cursor to Find and Display Products Above Price 30,000.
DECLARE 
	@Product_id INT ,
	@Product_Name VARCHAR(250), 
	@Price DECIMAL(10,2)
DECLARE Product_Cursor CURSOR

FOR SELECT * FROM Products
	WHERE PRICE > 30000

OPEN  Product_Cursor;

FETCH NEXT FROM  Product_Cursor INTO
	@Product_id ,
	@Product_Name, 
	@Price;

WHILE @@FETCH_STATUS = 0
BEGIN 
	--SELECT 
	PRINT CAST(@Product_id AS VARCHAR)+'-'+@Product_Name+'-'+ CAST(@Price AS VARCHAR);
	FETCH NEXT FROM Product_Cursor INTO 	@Product_id ,@Product_Name, @Price
END

CLOSE Product_Cursor

DEALLOCATE Product_Cursor

---4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
DECLARE 
	@Product_id INT 

DECLARE Product_Delete_Cursor CURSOR
FOR SELECT Product_id FROM Products

OPEN  Product_Delete_Cursor;

FETCH NEXT FROM  Product_Delete_Cursor INTO
	@Product_id 

WHILE @@FETCH_STATUS = 0
BEGIN 
		DELETE FROM Products
		WHERE Product_id = @Product_id 

		FETCH NEXT FROM PRODUCT_Delete_CURSOR
		INTO @Product_id 
END

CLOSE Product_Delete_Cursor

DEALLOCATE Product_Delete_Cursor


---------------------------------------------Part – B--------------------------------------------

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.	
	DECLARE @PRODID INT, @PRODNAME VARCHAR(250), @PRODPRICE DECIMAL(10,2)
--DECLARE
	DECLARE Product_CursorUpdate CURSOR
	FOR
	SELECT * FROM Products

--OPEN
	OPEN Product_CursorUpdate

--FETCH
	FETCH NEXT FROM Product_CursorUpdate
	INTO @PRODID, @PRODNAME, @PRODPRICE

--LOOP
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @PRODID AS PRODUCT_ID, @PRODNAME AS PRODUCT_NAME, (@PRODPRICE + @PRODPRICE*0.1) AS PRICE

		FETCH NEXT FROM Product_CursorUpdate
		INTO @PRODID, @PRODNAME, @PRODPRICE
	END

--CLOSE
	CLOSE Product_CursorUpdate

--DEALLOCATE
	DEALLOCATE Product_CursorUpdate


--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
	DECLARE @PRO_ID INT, @PRO_NAME VARCHAR(250), @PRO_PRICE DECIMAL(10,2)
--DECLARE
	DECLARE Product_PRICE_Cursor CURSOR
	FOR
	SELECT * FROM Products

--OPEN
	OPEN Product_PRICE_Cursor

--FETCH
	FETCH NEXT FROM Product_PRICE_Cursor
	INTO @PRO_ID, @PRO_NAME, @PRO_PRICE

--LOOP
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @PRO_ID AS PRODUCT_ID, @PRO_NAME AS PRODUCT_NAME, ROUND(@PRO_PRICE,0) AS PRICE

		FETCH NEXT FROM Product_PRICE_Cursor
		INTO @PRO_ID, @PRO_NAME, @PRO_PRICE
	END

--CLOSE
	CLOSE Product_PRICE_Cursor

--DEALLOCATE
	DEALLOCATE Product_PRICE_Cursor


--Part – C

-- Create the NewProducts table
CREATE TABLE NewProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)
	DECLARE @P_ID INT, @P_NAME VARCHAR(250), @P_PRICE DECIMAL(10,2)
--DECLARE
	DECLARE PRODUCT_NEW_CURSOR CURSOR
	FOR
	SELECT * FROM Products
	WHERE Product_Name = 'Laptop'

--OPEN
	OPEN PRODUCT_NEW_CURSOR

--FETCH
	FETCH NEXT FROM PRODUCT_NEW_CURSOR
	INTO @P_ID, @P_NAME, @P_PRICE

--LOOP
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO NewProducts VALUES(@P_ID, @P_NAME, @P_PRICE)

		FETCH NEXT FROM PRODUCT_NEW_CURSOR
		INTO @P_ID, @P_NAME, @P_PRICE
	END

--CLOSE
	CLOSE PRODUCT_NEW_CURSOR

--DEALLOCATE
	DEALLOCATE PRODUCT_NEW_CURSOR

--SELECT * FROM NewProducts

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts),  products
--with a price above 50000 to an archive table, removing them from the original Products table.


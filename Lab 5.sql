use CSE_B5_393;

---Part – A

---1. Write a function to print "hello world".

Create or Alter Function FN_PRINT_HELLOWORLD()
Returns VARCHAR(20)
As
Begin
	Return 'Hello World'
End

Select dbo.FN_PRINT_HELLOWORLD()

---2. Write a function which returns addition of two numbers.
Create or Alter Function FN_ADDITION
(
@num1 int,
@num2 int
)
Returns int
As
Begin
	Declare @ans int
	Set @ans = @num1 + @num2
	Return @ans
End

Select dbo.FN_ADDITION(1,2)

--3. Write a function to check whether the given number is ODD or EVEN.
Create or Alter Function FN_EVENODD
(
@num int
)
Returns VARCHAR(20)
As
Begin
	Declare @ans VARCHAR(20)
	If @num%2 = 0
		Set @ans = 'Even Number'
	Else 
		Set @ans = 'Odd Number'
	Return @ans
End

Select dbo.FN_EVENODD(3)

---4. Write a function which returns a table with details of a person whose first name starts with B.
Create or Alter Function FN_StartWithB()
Returns TABLE
As
	Return (Select * From Person Where FirstName Like 'B%')

Select * From dbo.FN_StartWithB()

--5. Write a function which returns a table with unique first names from the person table. 

CREATE OR ALTER FUNCTION FN_UNIQUE()
RETURNS TABLE
AS 
     RETURN(SELECT DISTINCT(FirstName) FROM Person)

SELECT * FROM DBO.FN_UNIQUE()

--6. Write a function to print number from 1 to N. (Using while loop)

CREATE OR ALTER FUNCTION FN_PRINT_1_TO_N(
@NUM INT)
RETURNS VARCHAR(500)
AS
BEGIN
     DECLARE @MSG VARCHAR(500) , @COUNT INT
	 SET @MSG =' '
	 SET @COUNT = 1

	 WHILE @COUNT<=@NUM
	 BEGIN

	 SET @MSG = @MSG + CAST(@COUNT AS VARCHAR) + ' '
	 SET @COUNT = @COUNT + 1
	 END
	 RETURN @MSG
END

SELECT DBO.FN_PRINT_1_TO_N(15)

--7. Write a function to find the factorial of a given integer.

CREATE OR ALTER  FUNCTION  fn_factorial(@n int)
RETURNS varchar(500)
AS
begin 
		declare @ans as varchar(max)
		set @ans=1
		declare @i int 
		set @i=1
		while @i<=@n
		begin 
			set @ans= @ans * @i
		set @i = @i+1
		end 
	return @ans
end
select dbo.fn_factorial(5)
--------Part – B-----------

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)

CREATE OR ALTER  FUNCTION  fn_compare(@n1 int,@n2 int)
RETURNS varchar(500)
AS
begin 
	return case
		when @n1>@n2 then '1st no is greater'
		when @n1<@n2 then '2nd no is greater'
		when @n1=@n2 then 'both are equal'
		end
end 
select dbo.fn_compare(2,4)

--9. Write a function to print the sum of even numbers between 1 to 20.

CREATE OR ALTER  FUNCTION  fn_sumeven()
RETURNS int
AS
BEGIN
	declare @sum  int=0, @i int 
		set @i=1
		while @i<=20
			if @i%2 =0
				set @sum = @sum+@i
			set @i= @i+1	
END

select dbo.fn_sumeven(3)

--10. Write a function that checks if a given string is a palindrome 

CREATE OR ALTER FUNCTION FN_PALINDROME(
@NUM INT )
RETURNS VARCHAR(500)
AS 
BEGIN
       DECLARE @MSG VARCHAR(50)
       IF REVERSE(@NUM) = @NUM
	       SET @MSG = 'NUMBER IS PALINDROME'
	   ELSE
           SET @MSG = 'NUMBER IS NOT PALINDROME'
	RETURN @MSG
END

SELECT DBO.FN_PALINDROME(125632)
SELECT DBO.FN_PALINDROME(12321)





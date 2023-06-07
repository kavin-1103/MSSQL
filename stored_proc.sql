CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    salesman_id INT,
    total_amount DECIMAL(10, 2)
);


INSERT INTO orders (order_id, order_date, customer_id, salesman_id, total_amount)
VALUES
    (1, '2023-01-01', 1, 1, 100.50),
    (2, '2023-01-02', 2, 2, 75.20),
    (3, '2023-01-03', 3, 1, 200.00);


	CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customer (customer_id, customer_name, city)
VALUES
    (1, 'John Doe', 'New York'),
    (2, 'Jane Smith', 'Los Angeles'),
    (3, 'Robert Johnson', 'Chicago');



	CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    salesman_name VARCHAR(100),
    commission DECIMAL(5, 2),
    city VARCHAR(50)
);


INSERT INTO salesman (salesman_id, salesman_name, commission, city)
VALUES
    (1, 'Michael Brown', 0.1, 'New York'),
    (2, 'Emily Davis', 0.15, 'Los Angeles'),
    (3, 'William Johnson', 0.12, 'Chicago');



	select * from orders

	--1

CREATE PROCEDURE GetDataFromTables AS
BEGIN
    
    SELECT * FROM orders;

    SELECT * FROM customer;

    SELECT * FROM salesman;
END


EXEC GetDataFromTables;



--2

CREATE PROCEDURE GetDataFromTables_1
    @tableName NVARCHAR(50)
AS
BEGIN
    IF @tableName = 'orders'
        SELECT * FROM orders;
    ELSE IF @tableName = 'customer'
        SELECT * FROM customer;
    ELSE IF @tableName = 'salesman'
        SELECT * FROM salesman;
    ELSE
        RAISERROR('Invalid table name provided.', 16, 1);
END


GetDataFromTables_1 @tableName = 'orders'



--3

CREATE PROCEDURE CheckTableNameValidity_2
    @tableName NVARCHAR(50)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
    IF EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = @tableName
    )
       BEGIN
			SET @sql = N'SELECT * FROM ' + QUOTENAME(@tableName);
			EXEC sp_executesql @sql;
		END
    ELSE
        SELECT 'Invalid table name' AS Result;
END

exec CheckTableNameValidity_2 @tableName='customer'



--4


CREATE PROCEDURE CheckTableNameValidity_3
    @tableName VARCHAR(50)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX);
    IF EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = @tableName
    )
       SELECT * FROM @tableName
    ELSE
        SELECT 'Invalid table name' AS Result;
END

exec CheckTableNameValidity_3 @tableName='customer'

drop procedure CheckTableNameValidity_3



--5


CREATE PROCEDURE spUpdateTotalAmount
(
     @order_Id int
     ,@total_amount money
)

AS
BEGIN
    UPDATE orders
    SET total_amount = @total_amount
    WHERE order_Id = @order_Id
END

spUpdateTotalAmount @order_Id=2,@total_amount=240.70




--6

select * from salesman

CREATE PROCEDURE usp_salesman  
   @salesman_Id int,  
   @salesman_name varchar OUTPUT  
AS  
BEGIN  
   SELECT *
   FROM salesman
   WHERE salesman_id = @salesman_Id  
END

DECLARE @salesman_Id int

Declare @salesman_name varchar

EXECUTE usp_salesman  @salesman_Id = 2, @salesman_name OUTPUT

PRINT @managerId




--7


CREATE TABLE tbl_Customers_1 (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

INSERT INTO tbl_Customers_1 (CustomerID, CustomerName)
VALUES (1, 'John Doe'),
       (2, 'Jane Smith');



CREATE TABLE tbl_Orders_1 (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES tbl_Customers_1(CustomerID)
);

INSERT INTO tbl_Orders_1 (OrderID, OrderDate, CustomerID)
VALUES (1, '2023-06-01', 1),
       (2, '2023-06-02', 2);




CREATE TABLE tbl_Products_1 (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(50),
    SupplierID INT,
    FOREIGN KEY (ProductID) REFERENCES tbl_Orders_1(OrderID)
);

INSERT INTO tbl_Products_1 (ProductID, ProductName, SupplierID)
VALUES (1, 'Product A', 1),
       (2, 'Product B', 2);

	   select * from tbl_Customers_1
	   select * from tbl_Orders_1
	   select * from tbl_Products_1





 CREATE PROCEDURE GetDataUsingJoins_1(
    @tableName NVARCHAR(50)
	)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    IF EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = @tableName
    )
       BEGIN
			SET @sql = N'SELECT * FROM ' + QUOTENAME(@tableName) + 'INNER JOIN tbl_Customers_1 on tbl_Orders_1.CustomerID = tbl_Customers_1.CustomerID';
			EXEC sp_executesql @sql;
		END
    ELSE
        RAISERROR('Invalid table name provided.', 16, 1);
END



--8

CREATE PROCEDURE GetDataUsingAggregateFunc(
    @tableName VARCHAR(50),
	@columnName varchar(50)
	)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    IF EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = @tableName
    )
       BEGIN
			SET @sql = 'SELECT AVG('+ Quotename(@columnName)+') FROM ' + QUOTENAME(@tableName);
			EXEC sp_executesql @sql;
		END
    ELSE
        RAISERROR('Invalid table name provided.', 16, 1);
END

select * from Orders

GetDataUsingAggregateFunc @tableName = 'Orders' , @columnName= 'total_amount'




--9



CREATE PROCEDURE uspGetDataUsingAggregateFuncSum(
    @tableName VARCHAR(50),
	@columnName varchar(50)
	)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    IF EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = @tableName
    )
       BEGIN
			SET @sql = 'SELECT SUM('+ Quotename(@columnName)+') FROM ' + QUOTENAME(@tableName);
			EXEC sp_executesql @sql;
		END
    ELSE
        RAISERROR('Invalid table name provided.', 16, 1);
END


uspGetDataUsingAggregateFuncSum @tableName = 'Orders' , @columnName= 'total_amount'




--10

CREATE PROCEDURE GetCustomerOrders_1
    @customerId INT
AS
BEGIN
    SELECT 
        O.order_id,
        O.order_date,
        P.salesman_id,
        P.commission
    FROM 
        Orders AS O
    INNER JOIN 
        customer AS C ON O.customer_id = C.customer_id
    INNER JOIN 
        salesman AS P ON O.salesman_id= P.salesman_id
    WHERE 
        C.customer_id = @customerId;
END


GetCustomerOrders_1 @customerId = 1


select * from building
select * from building_type

INSERT INTO building VALUES (12,'Syed',25,7567678,'Sundharapuram')

select * from customer


-- Create the Student table
CREATE TABLE Student (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT
);

-- Insert values into the Student table
INSERT INTO Student (Id, Name, Age)
VALUES
    (1, 'John Doe', 20),
    (2, 'Jane Smith', 22),
    (3, 'David Johnson', 19);

	select * from Student






--10

-- Create Table1
CREATE TABLE Table1 (
    Id INT PRIMARY KEY,
    s_Name NVARCHAR(50),
    Age INT
);

drop table Table1

-- Insert values into Table1
INSERT INTO Table1
VALUES
    (1, 'John Doe', 20),
    (2, 'Jane Smith', 22),
    (3, 'David Johnson', 19);

-- Create Table2
CREATE TABLE Table2 (
    Id INT PRIMARY KEY,
    Address NVARCHAR(100),
    City NVARCHAR(50)
);

-- Insert values into Table2
INSERT INTO Table2 (Id, Address, City)
VALUES
    (1, '123 Main St', 'New York'),
    (2, '456 Elm St', 'Los Angeles'),
    (3, '789 Oak St', 'Chicago');

-- Create Table3
CREATE TABLE Table3 (
    Id INT PRIMARY KEY,
    Email NVARCHAR(50),
    Phone NVARCHAR(20)
);

-- Insert values into Table3
INSERT INTO Table3 (Id, Email, Phone)
VALUES
    (1, 'john.doe@example.com', '123-456-7890'),
    (2, 'jane.smith@example.com', '987-654-3210'),
    (3, 'david.johnson@example.com', '555-123-4567');

-- Create Table4
CREATE TABLE Table4 (
    Id INT PRIMARY KEY,
    Description NVARCHAR(MAX)
);

-- Insert values into Table4
INSERT INTO Table4 (Id, Description)
VALUES
    (1, 'The customer is very happy'),
    (2, 'Enhanced monitoring procedures'),
    (3, 'But this is what happened at such a time');

	select * from Table1
	select * from Table2
	select * from Table3
	select * from Table4
	
			

create trigger insertTrigger
on table1
After insert
as
BEGIN
	insert into table2 values(4,'Gandhipuram','Coimbatore')
END

drop trigger insertTrigger
	

insert into table1 values(4,'James Bond',28)



--11


CREATE PROCEDURE InsertRecord_1
	
    @Column1Param INT,
    @Column2Param VARCHAR(50),
	@column3Param int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Table1 
    VALUES (@column1Param, @Column2Param, @Column3Param);
END;



CREATE PROCEDURE UpdateRecord
    @IdParam INT,
    @NewColumn2Param VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Table1
    SET s_Name = @NewColumn2Param
    WHERE Id = @IdParam;
END;



CREATE PROCEDURE DeleteRecord
    @IdParam INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Table1
    WHERE Id = @IdParam;
END;


CREATE PROCEDURE ReadRecords
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Table1;
END;

select * from meter

EXECUTE InsertRecord_1
    @Column1Param = 4,
    @Column2Param = 'James',
	@column3Param = 34;

EXECUTE UpdateRecord
    @IdParam = 1,
    @NewColumn2Param = 'Jimmy';

EXECUTE DeleteRecord
    @IdParam = 1;






	







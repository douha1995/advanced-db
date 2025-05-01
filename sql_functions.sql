use BikeStore
go
---------- How to create scaler function -----------------------
CREATE FUNCTION [schema_name.]function_name (parameter_list)
RETURNS data_type AS
BEGIN
    statements
    RETURN value
END

----------------------- scalar function examples -------------------------
CREATE FUNCTION sales.udfNetSale1(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END;


SELECT 
    sales.udfNetSale1(10,100,0.1) net_sale;


SELECT 
    order_id, 
    SUM(sales.udfNetSale(quantity, list_price, discount)) net_amount
FROM 
    sales.order_items
GROUP BY 
    order_id
ORDER BY
    net_amount DESC;


---------------------- Modifying a scalar function-------------------
create or ALTER FUNCTION [schema_name.]function_name (parameter_list)
    RETURN data_type AS
    BEGIN
        statements
        RETURN value
    END






-------------- SQL Server Table Variables -------------------------
DECLARE @table_variable_name TABLE (
    column_list
);


-- scope of table variables
-- example 
DECLARE @product_table TABLE (
    product_name VARCHAR(MAX) NOT NULL,
    brand_id INT NOT NULL,
    list_price DEC(11,2) NOT NULL
);

INSERT INTO @product_table
SELECT
    product_name,
    brand_id,
    list_price
FROM
    production.products
WHERE
    category_id = 1;

-- Restrictions on table variables
SELECT
    brand_name,
    product_name,
    list_price
FROM
    production.brands p
INNER JOIN @product_table bt 
    ON p.brand_id = bt.brand_id;


--- Table Variable in Functions
CREATE OR ALTER FUNCTION udfSplit(
    @string VARCHAR(5000), 
    @delimiter VARCHAR(50) = ' ')
RETURNS @parts TABLE
(    
idx INT IDENTITY PRIMARY KEY,
val VARCHAR(500)   
)
AS
BEGIN

DECLARE @index INT = -1;

WHILE (LEN(@string) > 0) 
BEGIN 
    SET @index = CHARINDEX(@delimiter , @string)  ;
    
    IF (@index = 0) AND (LEN(@string) > 0)  
    BEGIN  
        INSERT INTO @parts 
        VALUES (@string);
        BREAK  
    END 

    IF (@index > 1)  
    BEGIN  
        INSERT INTO @parts 
        VALUES (LEFT(@string, @index - 1));
        
        SET @string = RIGHT(@string, (LEN(@string) - @index));  
    END 
    ELSE
    SET @string = RIGHT(@string, (LEN(@string) - @index)); 
    END
RETURN
END
GO


SELECT 
    * 
FROM 
    udfSplit('foo,bar,baz',',');



------------------------- SQL Server Table-valued Functions-------------------
CREATE FUNCTION udfProductInYear (
    @model_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;


SELECT 
    * 
FROM 
    udfProductInYear(2017);


SELECT 
    product_name,
    list_price
FROM 
    udfProductInYear(2018);


ALTER FUNCTION udfProductInYear (
    @start_year INT,
    @end_year INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        product_name,
        model_year,
        list_price
    FROM
        production.products
    WHERE
        model_year BETWEEN @start_year AND @end_year


SELECT 
    product_name,
    model_year,
    list_price
FROM 
    udfProductInYear(2017,2018)
ORDER BY
    product_name;



CREATE FUNCTION udfContacts()
  RETURNS @contacts TABLE (
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(255),
        phone VARCHAR(25),
        contact_type VARCHAR(20)
    )
AS
BEGIN
    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Staff'
    FROM
        sales.staffs;

    INSERT INTO @contacts
    SELECT 
        first_name, 
        last_name, 
        email, 
        phone,
        'Customer'
    FROM
        sales.customers;
    RETURN;
END;


SELECT 
    * 
FROM
    udfContacts();

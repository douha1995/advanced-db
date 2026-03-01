use BikeStore
go
-- ============================================================================
-- SQL SERVER STORED PROCEDURES
-- ============================================================================
-- This file covers:
--   1. Creating Procedures
--   2. Executing Procedures
--   3. Modifying & Dropping Procedures
--   4. Procedure Parameters (Input, Output, Default Values)
--   5. Variables in Procedures
--   6. Conditional Logic (IF-ELSE)
-- ============================================================================

SELECT 
	product_name, 
	list_price
FROM 
	production.products
ORDER BY 
	product_name;

-- ----------------------------------------------------------------------------
-- SECTION 1: CREATE PROCEDURE
-- ----------------------------------------------------------------------------
CREATE PROCEDURE uspProductList_1
AS
BEGIN
    SELECT 
        product_name, 
        list_price
    FROM 
        production.products
    ORDER BY 
        product_name;
END;

-- ----------------------------------------------------------------------------
-- SECTION 2: EXECUTE PROCEDURE
-- ----------------------------------------------------------------------------
EXEC uspProductList_1;

EXECUTE uspProductList_1;


-- ----------------------------------------------------------------------------
-- SECTION 3: MODIFY PROCEDURE (ALTER)
-- ----------------------------------------------------------------------------
 ALTER PROCEDURE uspProductList_1
    AS
    BEGIN
        SELECT 
            product_name, 
            list_price
        FROM 
            production.products
        ORDER BY 
            list_price 
    END;

EXECUTE uspProductList_1;

-- DROP PROCEDURE
DROP PROCEDURE uspProductList_1;


-- ----------------------------------------------------------------------------
-- SECTION 4: PROCEDURE PARAMETERS
-- ----------------------------------------------------------------------------
-- create stored procedure to find the products whose list prices are greater than
-- an input price 

drop procedure uspFindProducts

create PROCEDURE uspFindProducts(@min_list_price AS DECIMAL)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price
    ORDER BY
        list_price;
END;


EXEC uspFindProducts 150;


ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL
    ,@max_list_price AS DECIMAL
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price
    ORDER BY
        list_price;
END;


EXECUTE uspFindProducts 2000 ,1000
    @min_list_price = 900, 
    @max_list_price = 1000;


ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = 999999
    ,@name AS VARCHAR(200)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

EXECUTE uspFindProducts 
    @name = 'Trek';

EXECUTE uspFindProducts 
    @name = 'Trek';



ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = NULL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        list_price <= @max_list_price AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;

EXECUTE uspFindProducts 
    @min_list_price = 6000,
    @name = 'Trek';


ALTER PROCEDURE uspFindProducts(
    @min_list_price AS DECIMAL = 0
    ,@max_list_price AS DECIMAL = NULL
    ,@name AS VARCHAR(max)
)
AS
BEGIN
    SELECT
        product_name,
        list_price
    FROM 
        production.products
    WHERE
        list_price >= @min_list_price AND
        (@max_list_price IS NULL OR list_price <= @max_list_price) AND
        product_name LIKE '%' + @name + '%'
    ORDER BY
        list_price;
END;
 
EXECUTE uspFindProducts 
    @min_list_price = 6000,
    @name = 'Trek';


-- ----------------------------------------------------------------------------
-- SECTION 5: VARIABLES
-- ----------------------------------------------------------------------------

DECLARE @model_year SMALLINT;

SET @model_year = 2019;

SELECT
    product_name,
    model_year,
    list_price 
FROM 
    production.products
WHERE 
    model_year = @model_year
ORDER BY
    product_name;



DECLARE @product_count INT;
SET @product_count = (
    SELECT 
        COUNT(*) 
    FROM 
        production.products 
);

SELECT @product_count;

PRINT @product_count;


-- ----------------------------------------------------------------------------
-- SECTION 6: PROCEDURE WITH VARIABLES
-- ----------------------------------------------------------------------------
Create  PROCEDURE uspGetProductList1(
    @model_year SMALLINT
) AS 
BEGIN
    DECLARE @product_list VARCHAR(200);

    SET @product_list = '';

    SELECT
        @product_list =  product_name + CHAR(10)
    FROM 
        production.products
    WHERE
        model_year = @model_year
    ORDER BY 
        product_name;

    PRINT @product_list;
END;

exec uspGetProductList1 2019

-- ----------------------------------------------------------------------------
-- SECTION 7: OUTPUT PARAMETERS
-- ----------------------------------------------------------------------------

CREATE PROCEDURE uspFindProductByModel (
    @model_year SMALLINT,
    @product_count INT OUTPUT
) AS
BEGIN
    SELECT 
        product_name,
        list_price
    FROM
        production.products
    WHERE
        model_year = @model_year;

    --set @product_count = (select @@ROWCOUNT);
	select @product_count = @@ROWCOUNT;
END;


DECLARE @count INT;
EXEC uspFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';



BEGIN
    DECLARE @sales INT;

    SELECT 
        @sales = SUM(list_price * quantity)
    FROM
        sales.order_items i
        INNER JOIN sales.orders o ON o.order_id = i.order_id
    WHERE
        YEAR(order_date) = 2017;

    SELECT @sales;

    IF @sales > 10000000
    BEGIN
        PRINT 'Great! The sales amount in 2017 is greater than 10,000,000';
    END
    ELSE
    BEGIN
        PRINT 'Sales amount in 2017 did not reach 10,000,000';
    END
END

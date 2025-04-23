use BikeStore
go 

SELECT 
	product_name, 
	list_price
FROM 
	production.products
ORDER BY 
	product_name;

------------ create procedure ------------------------
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

-------------- execution of procedure --------------------------
EXEC uspProductList_1;

EXECUTE uspProductList_1;


-------------- modify procedure --------------------------------
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

------------ drop procedure 
DROP PROCEDURE uspProductList_1;


---------- Procedure Parameters --------------------------
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


---------------- variables --------------------------------------

DECLARE @model_year SMALLINT;

SET @model_year = 2018;

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


--------------- procedure with variables ------------------------------------
Create  PROCEDURE uspGetProductList(
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

exec uspGetProductList 2019

--------------- procedure output --------------------------------------

CREATE PROCEDURE uspFindProductByModel_1 (
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

    set @product_count = (select @@ROWCOUNT);
	select @product_count = @@ROWCOUNT;
END;


DECLARE @count INT;
EXEC uspFindProductByModel_1
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

USE BikeStore
GO
------------------- Clustered Indexes----------------------
CREATE TABLE production.parts(
    part_id   INT NOT NULL, 
    part_name VARCHAR(100)
);

INSERT INTO 
    production.parts(part_id, part_name)
VALUES
    (1,'Frame'),
    (2,'Head Tube'),
    (3,'Handlebar Grip'),
    (4,'Shock Absorber'),
    (5,'Fork');


SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;



CREATE TABLE production.part_prices(
    part_id int,
    valid_from date,
    price decimal(18,4) not null,
    PRIMARY KEY(part_id, valid_from) 
);


ALTER TABLE production.parts
ADD PRIMARY KEY(part_id);

SELECT 
    part_id, 
    part_name
FROM 
    production.parts
WHERE 
    part_id = 5;


CREATE CLUSTERED INDEX ix_parts_id
ON production.parts (part_id); 

--------------------- non-clustered indexes -------------------
SELECT 
    customer_id, 
    city
FROM 
    sales.customers
WHERE 
    city = 'Atwater';


CREATE INDEX ix_customers_city
ON sales.customers(city);

------------------ nonclustered index for multiple columns ---------

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';


CREATE INDEX ix_customers_name 
ON sales.customers(last_name, first_name);

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Albert';

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    first_name = 'Adam';

------------------------- Rename Index -----------------
EXEC sp_rename 
        @objname = N'sales.customers.ix_customers_city',
        @newname = N'ix_cust_city' ,
        @objtype = N'INDEX';


------------------------ Unique Index ---------------------
SELECT
    customer_id, 
    email 
FROM
    sales.customers
WHERE 
    email = 'caren.stephens@msn.com';



SELECT 
    email, 
    COUNT(email)
FROM 
    sales.customers
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;


CREATE UNIQUE INDEX ix_cust_email 
ON sales.customers(email);


CREATE TABLE t1 (
    a INT, 
    b INT
);


CREATE UNIQUE INDEX ix_uniq_ab 
ON t1(a, b);

------------------- DROP INDEX  ------------------------

DROP INDEX 
    ix_customers_name ON sales.customers,
    ix_cust_fullname ON sales.customers;


---------------------- Indexes with Included Columns ---------------

SELECT    
    customer_id, 
    city
FROM    
    sales.customers
WHERE 
    city = 'Atwater';


SELECT    
	first_name,
	last_name, 
	city
FROM    
	sales.customers
WHERE city = 'Atwater';



DROP INDEX ix_customers_city 
ON sales.customers;


CREATE INDEX ix_cust_city_inc
ON sales.customers(city)
INCLUDE(first_name,last_name);


SELECT    
	first_name,
	last_name, 
	city
FROM    
	sales.customers
WHERE city = 'Atwater';


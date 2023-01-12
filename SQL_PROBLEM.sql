CREATE DATABASE ONLINE_SHOP
-----
DROP DATABASE ONLINE_SHOP

USE ONLINE_SHOP
----
USE master

CREATE TABLE ADDRESS
(
ADDRESS_ID INT IDENTITY(1,1) PRIMARY KEY ,
COUNTRY_NAME VARCHAR(40) NOT NULL,
TOWN_NAME VARCHAR(40) NOT NULL,
ZIP_CODE VARCHAR(10) NOT NULL,
ADDRESS_NAME VARCHAR(40) NOT NULL,
ADDRESS_NUMBER TINYINT NOT NULL
)

CREATE TABLE CLIENT
(
CLIENT_ID INT IDENTITY(1,1) PRIMARY KEY,
CLIENT_NUMBER INT UNIQUE,
EMAIL VARCHAR(30) NOT NULL UNIQUE,
USERNAME VARCHAR(20) NOT NULL UNIQUE,
PASSWORD BINARY(16) NOT NULL ,
FIRST_NAME VARCHAR(10) NOT NULL,
LAST_NAME VARCHAR(10) NOT NULL,
PHONE_NUMBER VARCHAR(10) NOT NULL,
IS_BLOCKED BIT CHECK (IS_BLOCKED IS NOT NULL),
DEFAULT_ADDRESS INT FOREIGN KEY REFERENCES ADDRESS(ADDRESS_ID) UNIQUE
)

CREATE TABLE CLIENTS_ADDRESSES
(
ID INT IDENTITY(1,1) PRIMARY KEY,
CLIENT_ID INT FOREIGN KEY REFERENCES CLIENT(CLIENT_ID),
ADDRESS_ID INT FOREIGN KEY REFERENCES ADDRESS(ADDRESS_ID)
)


SELECT * FROM ADDRESS

INSERT INTO ADDRESS
VALUES ('Bulgaria','Plovdiv','4220','Dunav',3),
       ('Bulgaria','Sofia','5692','Petur Beron',6),
	   ('Bulgaria','Veliko Turnovo','1212','Preslav',14),
	   ('Bulgaria','Haskovo','3541','Izgrev',67),
	   ('Bulgaria','Pazardjik','9713','Struma',8),
	   ('Bulgaria','Kalofer','7341','Hristo Botev',10)

SELECT * FROM CLIENT


INSERT INTO CLIENT
VALUES (CAST((RAND() * (899999) + 100000) as int),'scoobydoo@gmail.com','scooby',CONVERT(BINARY,'poslushno123'),'Nikolai','Petrov','0320120311',1,1),
       (CAST((RAND() * (899999) + 100000) as int),'pancho@gmail.com','pancho',CONVERT(BINARY,'kazarma23'),'Pancho','Velkov','0320123131',0,2),
	   (CAST((RAND() * (899999) + 100000) as int),'darinb@gmail.com','darinb',CONVERT(BINARY,'ghsdiahsofa'),'Darin','Borisov','0320187511',0,3),
	   (CAST((RAND() * (899999) + 100000) as int),'georgiv@gmail.com','goshkov',CONVERT(BINARY,'goshkomoshko'),'Georgi','Videv','032012684',0,4),
	   (CAST((RAND() * (899999) + 100000) as int),'hristina@gmail.com','dhrisi',CONVERT(BINARY,'hlsaldas1'),'Hristina','Petrova','0367677311',0,6),
	   (CAST((RAND() * (899999) + 100000) as int),'kremena@gmail.com','kremenad',CONVERT(BINARY,'ghsdkljdlk'),'Kremena','Trifonova','0329867311',1,5)

SELECT * FROM CLIENTS_ADDRESSES

INSERT INTO CLIENTS_ADDRESSES
VALUES (3,6), 
       (3,5),
	   (3,4),
	   (4,3),
	   (5,2),
	   (6,2),
       (2,4),
	   (1,5)


CREATE TABLE STATUS
(
STATUS_ID INT IDENTITY(1,1) PRIMARY KEY,
STATUS_NAME VARCHAR(40) NOT NULL UNIQUE
)

SELECT * FROM STATUS

INSERT INTO STATUS 
VALUES ('Izpratena'),
       ('Neplatena'),
	   ('Odobreno plashtane'),
	   ('Podgotvena za izprashtane'),
	   ('Poluchena')

	

CREATE TABLE SPECIFICATION
(
SPEC_ID INT IDENTITY(1,1) PRIMARY KEY,
SPECIFICATION_NAME VARCHAR(30) NOT NULL UNIQUE
)

CREATE TABLE CATEGORY
(
CATEGORY_ID INT IDENTITY(1,1) PRIMARY KEY,
CATEGORY_NAME VARCHAR(30) NOT NULL UNIQUE,
BASE_CATEGORY INT FOREIGN KEY REFERENCES CATEGORY(CATEGORY_ID) DEFAULT (NULL)
)


SELECT * FROM CATEGORY

INSERT INTO CATEGORY
VALUES ('MODA', DEFAULT),
       ('MUJE', 1),
	   ('JENI', 1),
	   ('DECA', 1),
	   ('BIJUTA',3 ),
	   ('PORFEILI',2),
	   ('DETSKI RANICI', 4),
	   ('SWAROVSKI', 5 ),
	   ('KOJENI', 6)

SELECT * FROM SPECIFICATION

INSERT INTO SPECIFICATION
VALUES ('CVQT'),
       ('RAZMER'),
	   ('GARANCIQ'),
	   ('MATERIQ'),
	   ('DETAILI'),
	   ('PROIZHOD')

SELECT * FROM CATEGORY

INSERT INTO CATEGORY
VALUES ('HRANITELNI PRODUKTI',DEFAULT),
       ('ZELENCHUCI',10),
       ('PLODOVE',10)

CREATE TABLE CATEGORIES_SPECS
(
CS_ID INT PRIMARY KEY IDENTITY(1,1),
CATEGORY_ID INT FOREIGN KEY REFERENCES CATEGORY(CATEGORY_ID) NOT NULL,
SPEC_ID INT FOREIGN KEY REFERENCES SPECIFICATION(SPEC_ID) NOT NULL
)


SELECT * FROM CATEGORY
SELECT * FROM SPECIFICATION
SELECT * FROM CATEGORIES_SPECS

INSERT INTO CATEGORIES_SPECS
VALUES (5,1),
       (5,5),
	   (5,3),
	   (5,2),
	   (7,4),
	   (7,5),
	   (11,6),
	   (12,6)


	--------------------------TO DO HISTORY TABLE------------   
CREATE TABLE PRODUCT
(
PRODUCT_ID INT IDENTITY(1,1) PRIMARY KEY,
PRODUCT_NUMBER INT UNIQUE,
PRODUCT_NAME VARCHAR(30) NOT NULL UNIQUE,
DELIVERY_PRICE SMALLMONEY NOT NULL,
SALE_PRICE SMALLMONEY NOT NULL,
VALID_FROM DATETIME2 GENERATED ALWAYS AS ROW START,
VALID_TO DATETIME2 GENERATED ALWAYS AS ROW END ,
PERIOD FOR SYSTEM_TIME (VALID_FROM, VALID_TO)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.PRODUCT_HISTORY))

SELECT * FROM PRODUCT_HISTORY
------------------------------------------------------
INSERT INTO PRODUCT
VALUES (CAST((RAND() * (899999) + 100000) as int),'CHERESHI',5.20, 6.20,DEFAULT,DEFAULT),
       (CAST((RAND() * (899999) + 100000) as int),'KRASTAVICI',3.50, 4.10,DEFAULT,DEFAULT),
	   (CAST((RAND() * (899999) + 100000) as int),'PRASKOVI',2.20, 4.20 ,DEFAULT,DEFAULT),
	   (CAST((RAND() * (899999) + 100000) as int),'DOMATKI',3.20, 6.50,DEFAULT,DEFAULT)

SELECT * FROM PRODUCT
SELECT * FROM PRODUCT_HISTORY

UPDATE PRODUCT
SET SALE_PRICE = 4.80
WHERE PRODUCT_NAME LIKE 'KRASTAVICI'

UPDATE PRODUCT
SET SALE_PRICE = 4.50
WHERE PRODUCT_NAME LIKE 'praskovi'


CREATE TABLE ORDERS
(
ORDER_ID INT IDENTITY(1,1) PRIMARY KEY,
ORDER_NUMBER INT NOT NULL UNIQUE,
DATE_TIME DATETIME DEFAULT GETDATE() NOT NULL,
STATUS_ID INT FOREIGN KEY REFERENCES STATUS(STATUS_ID) DEFAULT(1) NOT NULL,
CLIENT_ID INT FOREIGN KEY REFERENCES CLIENT(CLIENT_ID) NOT NULL 
)

CREATE TABLE ORDERS_PRODUCTS
(
OP_ID INT PRIMARY KEY IDENTITY(1,1),
ORDER_ID INT FOREIGN KEY REFERENCES ORDERS(ORDER_ID) NOT NULL,
PRODUCT_ID INT FOREIGN KEY REFERENCES PRODUCT(PRODUCT_ID) NOT NULL,
QUANTITY INT NOT NULL CHECK(QUANTITY>=1)
)


CREATE TABLE PRODUCTS_CATEGORIES
(
PC_ID INT IDENTITY(1,1) PRIMARY KEY,
CATEGORY_ID INT FOREIGN KEY REFERENCES CATEGORY(CATEGORY_ID) NOT NULL,
PRODUCT_ID INT FOREIGN KEY REFERENCES PRODUCT(PRODUCT_ID) NOT NULL,
)


CREATE TABLE PRODUCTS_SPECS 
(
ID INT IDENTITY(1,1) PRIMARY KEY,
PC_ID INT FOREIGN KEY REFERENCES PRODUCTS_CATEGORIES(PC_ID) NOT NULL,
CS_ID INT FOREIGN KEY REFERENCES CATEGORIES_SPECS(CS_ID) NOT NULL,
SPECIFICATION_VALUE VARCHAR(20) NOT NULL
)



SELECT * FROM PRODUCT


INSERT INTO PRODUCT
VALUES (CAST((RAND() * (899999) + 100000) as int),'GRIVNICHKA', 56.20, 102.99 ,DEFAULT,DEFAULT)



---------------------------------------------------------------------------------------------------------------------------
SELECT * FROM ORDERS
SELECT * FROM CLIENT

INSERT INTO ORDERS
VALUES (CAST((RAND() * (899999) + 100000) as int),DEFAULT,1,2),
       (CAST((RAND() * (899999) + 100000) as int),DEFAULT,2,3),
       (CAST((RAND() * (899999) + 100000) as int),DEFAULT,2,4),
       (CAST((RAND() * (899999) + 100000) as int),DEFAULT,1,5),
       (CAST((RAND() * (899999) + 100000) as int),DEFAULT,2,3),
       (CAST((RAND() * (899999) + 100000) as int),DEFAULT,1,2)
	   
SELECT * FROM ORDERS_PRODUCTS
SELECT * FROM ORDERS
SELECT * FROM PRODUCT
	   
INSERT INTO ORDERS_PRODUCTS
VALUES (1,3,2),
       (2,2,5),
	   (3,3,4),
	   (5,2,3),
	   (5,4,6),
	   (5,1,6)


SELECT * FROM PRODUCT
SELECT * FROM CATEGORY
SELECT * FROM PRODUCTS_CATEGORIES

INSERT INTO PRODUCTS_CATEGORIES
VALUES (11,2),
       (11,4),
	   (12,3),
	   (12,1),
	   (5,5)


---------------ADP FOR CREATING A NEW ORDER WITH PARAMS-------
CREATE PROCEDURE NEW_ORDER(@CLIENT_ID INT, )
--------------------------------------------------------------

	  
---------VIEW WITH ALL CLIENTS THAT ARE NOT BLOCKED AND HAVE ORDERS-------
SELECT * FROM CLIENT
SELECT * FROM ORDERS
SELECT * FROM ACTIVE_CLIENTS

CREATE VIEW ACTIVE_CLIENTS 
AS  
SELECT DISTINCT C.FIRST_NAME, C.LAST_NAME, C.IS_BLOCKED
FROM CLIENT C  LEFT JOIN  ORDERS O 
ON C.CLIENT_ID= O.CLIENT_ID
WHERE C.IS_BLOCKED = 0 AND O.ORDER_NUMBER IS NOT NULL

--------------------------------------------------


                     ----UDF WHO GET PARAMETERS(CATEGORY, DATE)---
------RETURNS PRODUCTS FROM THIS CATEGORY, ORDERS AND ON CURRENT DATE OR AFTER THIS DATE------- 

SELECT * FROM PRODUCT
SELECT * FROM ORDERS
SELECT * FROM ORDERS_PRODUCTS
SELECT * FROM PRODUCTS_CATEGORIES
--
CREATE FUNCTION ORDER_ITEMS_ON_DATE
(@CATEGORY_ID INT , @DATE DATE)
RETURNS TABLE 
AS
RETURN (SELECT O.ORDER_NUMBER, P.PRODUCT_NAME, O.DATE_TIME 
FROM ORDERS_PRODUCTS OP LEFT JOIN PRODUCT P 
ON OP.PRODUCT_ID = P.PRODUCT_ID
                        LEFT JOIN ORDERS O
ON OP.ORDER_ID = O.ORDER_ID
LEFT JOIN PRODUCTS_CATEGORIES PC 
ON OP.PRODUCT_ID = PC.PRODUCT_ID
WHERE PC.CATEGORY_ID = @CATEGORY_ID AND DATE_TIME >= @DATE
)
--
SELECT * FROM ORDER_ITEMS_ON_DATE(11,'2023-01-11')
SELECT * FROM ORDER_ITEMS_ON_DATE(11,'2023-01-13')
-----------------------------------------------------------------

--------BEST SELLERS---------

SELECT * FROM PRODUCT
SELECT * FROM ORDERS_PRODUCTS

SELECT P.PRODUCT_NAME, SUM(QUANTITY) AS QUANTITY
FROM ORDERS_PRODUCTS OP LEFT JOIN PRODUCT P
ON OP.PRODUCT_ID = P.PRODUCT_ID
GROUP BY PRODUCT_NAME
ORDER BY 2 DESC
----------------------------

------------BEST COMBO-----------
SELECT * FROM PRODUCT
SELECT * FROM ORDERS_PRODUCTS

GO
DECLARE 
@PRODUCT_ID INT = ( SELECT PRODUCT_ID 
FROM PRODUCT WHERE PRODUCT_NAME LIKE 'KRASTAVICI' )
DECLARE
@ORDER_ID INT =( SELECT TOP(2)ORDER_ID FROM ORDERS_PRODUCTS 
WHERE ORDER_ID = (SELECT ORDER_ID FROM ORDERS_PRODUCTS
                   GROUP BY ORDER_ID
                   HAVING COUNT(ORDER_ID) > 1 ) AND PRODUCT_ID = @PRODUCT_ID)
SELECT P.PRODUCT_ID, P.PRODUCT_NUMBER ,P.PRODUCT_NAME FROM ORDERS_PRODUCTS OP
JOIN PRODUCT P ON P.PRODUCT_ID = OP.PRODUCT_ID
WHERE ORDER_ID = @ORDER_ID

----------------------------------

-------THE UPDATES ON PRODUCT FOR THE LAST 30 DAYS-------------
SELECT * FROM PRODUCT

UPDATE PRODUCT
SET SALE_PRICE = 5.10
WHERE PRODUCT_NAME LIKE 'KRASTAVICI'

DECLARE @PRODUCT_NAME VARCHAR(20) = 'KRASTAVICI'
SELECT PRODUCT_NAME, SALE_PRICE,VALID_FROM,VALID_TO,  DATEDIFF(DAY, GETDATE() - DAY(29), GETDATE()) AS [DATEDIF]
FROM PRODUCT_HISTORY
WHERE  DATEDIFF(DAY, GETDATE() - DAY(29), GETDATE()) <= 30 AND PRODUCT_NAME = @PRODUCT_NAME
GROUP BY PRODUCT_NAME,SALE_PRICE,VALID_FROM,VALID_TO
---------------------------------

----------------QUERY FOR PROFIT ------------
SELECT * FROM ORDERS_PRODUCTS
SELECT * FROM ORDERS
SELECT * FROM PRODUCT

GO
DECLARE
@FROM_DATE DATE = '2022-01-01',
@TO_DATE DATE = '2023-01-20',
@STATUS_ID INT = (SELECT STATUS_ID FROM STATUS WHERE STATUS_NAME LIKE 'NEPLATENA')
SELECT SUM((P.SALE_PRICE-P.DELIVERY_PRICE)*OP.QUANTITY) AS TOTAT_PROFIT,  O.STATUS_ID, @FROM_DATE AS [FROM_DATE], @TO_DATE[TO_DATE] FROM ORDERS_PRODUCTS OP
JOIN PRODUCT P ON OP.PRODUCT_ID = P.PRODUCT_ID
JOIN ORDERS O ON OP.ORDER_ID = O.ORDER_ID
WHERE O.STATUS_ID = @STATUS_ID AND O.DATE_TIME BETWEEN @FROM_DATE AND @TO_DATE
GROUP BY O.STATUS_ID

----------------------------------------------


--BEFORE THAT EVERYTHING IS FINISHED--

INSERT INTO PRODUCTS_SPECS
VALUES (1,6,'TURCIQ'), 
       (2,6, 'POLSHA'),
	   (3,6, 'GURCIQ'),
	   (4,6, 'BULGARIA'),
	   (5,5, 'FINNA IZRABOTKA'),
	   (5,3, '12 MESECA'),
	   (5,2, 'WRIST-M')


	  -------------------
SELECT PRODUCT_NAME, CATEGORY_ID, SPECIFICATION_NAME, SPECIFICATION_VALUE 
FROM PRODUCTS_SPECS PS  JOIN PRODUCT P ON P.PRODUCT_ID = PS.PRODUCT_ID
                JOIN SPECIFICATION S ON S.SPEC_ID = PS.SPECS_ID












-------------------CREATING AD.PROCEDURE------------------

CREATE PROCEDURE MAKE_ORDER(@CLIENT_ID INT, )

----------------------------------------------







    



   
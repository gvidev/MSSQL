CREATE DATABASE ONLINE_SHOP
DROP DATABASE ONLINE_SHOP

USE ONLINE_SHOP

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
EMAIL VARCHAR(30) NOT NULL UNIQUE,
USERNAME VARCHAR(20) NOT NULL UNIQUE,
PASSWORD VARCHAR(20) NOT NULL,
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
VALUES ('scoobydoo@gmail.com','scooby','poslushnokuchence123','Nikolai','Petrov','0320120311',1,1),
       ('pancho@gmail.com','pancho','kazarma23','Pancho','Velkov','0320123131',0,2),
	   ('darinb@gmail.com','darinb','ghsdiahsofa','Darin','Borisov','0320187511',0,3),
	   ('georgiv@gmail.com','goshkov','goshkomoshko','Georgi','Videv','032012684',0,4),
	   ('hristina@gmail.com','dhrisi','hlsaldas1','Hristina','Petrova','0367677311',0,6),
	   ('kremena@gmail.com','kremenad','ghsdkljdlk','Kremena','Trifonova','0329867311',1,5)

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




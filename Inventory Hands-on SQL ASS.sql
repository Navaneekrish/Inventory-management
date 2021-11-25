CREATE DATABASE INVENTORY;

USE INVENTORY;

---CREATING SUPPLIER TABLE---
CREATE TABLE SUP
(SID CHAR(7),
SNAME VARCHAR(17) NOT NULL,
SADDR VARCHAR(25) NOT NULL,
SCITY VARCHAR(16) DEFAULT'DELHI',
SPHONE CHAR(10) UNIQUE,
EMAIL VARCHAR(20));

ALTER TABLE SUP
ALTER COLUMN SID CHAR(7) NOT NULL;
ALTER TABLE SUP
ADD CONSTRAINT PKSID PRIMARY KEY (SID);

---CREATING PRODUCT TABLE----
CREATE TABLE PROD
(PID CHAR (7) PRIMARY KEY (PID),
PDESC VARCHAR(15) NOT NULL,
PRICE INT CHECK (PRICE>0),
CATEGORY VARCHAR(15) CHECK (CATEGORY LIKE 'IT' OR CATEGORY LIKE 'HA' OR CATEGORY LIKE 'HC'));

ALTER TABLE PROD
ADD CONSTRAINT FKPR FOREIGN KEY(SID) REFERENCES SUP(SID);

---CREATING CUSTOMER TABLE----
CREATE TABLE CUST
(CID CHAR(7) PRIMARY KEY (CID),
CNAME VARCHAR (20) NOT NULL,
ADDR VARCHAR(20) NOT NULL,
CITY VARCHAR(15) NOT NULL,
PHONE CHAR(10) NOT NULL,
EMAIL VARCHAR (20) NOT NULL,
DOB DATE CHECK (DOB<'01-01-2000'));

---CREATING ORDER TABLE----
CREATE TABLE ORD
(OID CHAR(7) PRIMARY KEY(OID),
ODATE DATE,
CID CHAR(7) REFERENCES CUST(CID),
PID CHAR(7) REFERENCES PROD(PID),
OQTY INT CHECK (OQTY>=1));

---CREATING STOCK TABLE----
CREATE TABLE STK
(PID CHAR(7) REFERENCES PROD (PID),
SQTY INT CHECK(SQTY>=0),
ROL INT CHECK(ROL>0),
MOQ INT CHECK(MOQ>=5));

---CREATING PURCHASE TABLE----
CREATE TABLE PUR
(PID CHAR(7),
SID CHAR(7),
PQTY INT,
DOP DATE);


SELECT * FROM SUP;
SELECT * FROM PROD;
SELECT * FROM CUST;
SELECT * FROM ORD;
SELECT * FROM STK;
SELECT * FROM PUR;

--------------------------------------------------------------------------------

--- INSERTING MY DATA TO SUPPLIER TABLES--
DROP PROCEDURE ADDSUP;
CREATE PROCEDURE ADDSUP (@SI CHAR(7),@SN VARCHAR(20),@SA VARCHAR(30),@SC VARCHAR(20),@SPH CHAR(13),@SE VARCHAR(30))
AS
BEGIN
      INSERT INTO SUP
	  VALUES (@SI,@SN,@SA,@SC,@SPH,@SE);

	  SELECT * FROM SUP WHERE SID=@SI;
	  
END;

SELECT * FROM SUP;

ADDSUP S0001,'LG AGENCY','KOVIL STREET','KUMBAKONAM',9283736353,'LGAGENCY01@GMAIL.COM';
ADDSUP S0002,'SAMSUNG AGENCY','ULLUR NAGAR','THANJAVUR',9867565443,'SAMAGENCY02@GMAIL.COM';
ADDSUP S0003,'SIVA OIL','MM NAGAR','CHENNAI',8978675412,'SIVAOIL03@GMAIL.COM';
ADDSUP S0004,'ASHWIN MALL','BOMBAY STREET','CHENNAI',8220473412,'ASHMALL04@GMAIL.COM';
ADDSUP S0005,'BIG BAZZAR','OMG ROAD','SOLIGANALUR',9443665134,'BIGBA05@GMAIL.COM';

--------------------------------------------------------------------------------

--- INSERTING MY DATA TO PRODUCT TABLES--

CREATE PROCEDURE ADDPROD (@PI CHAR(7),@PD VARCHAR(30),@PP INT,@PCAT VARCHAR(30),@SI CHAR(7))
AS
BEGIN
	  INSERT INTO PROD
	  VALUES (@PI,@PD,@PP,@PCAT,@SI);

	  SELECT * FROM PROD WHERE PID = @PI;

END;

SELECT * FROM PROD;
--------------------------------------------------------------------------------

--- INSERTING MY DATA TO CUSTOMER TABLES--

CREATE PROCEDURE ADDCUST (@CI CHAR(7),@CN VARCHAR(30),@CAD VARCHAR(30),@CC VARCHAR(30),@CPH CHAR(13),@CE VARCHAR(30),@CDB DATE)
AS
BEGIN
	INSERT INTO CUST
	VALUES (@CI,@CN,@CAD,@CC,@CPH,@CE,@CDB);

	SELECT * FROM CUST WHERE CID=@CI;
END;

SELECT * FROM CUST;
--------------------------------------------------------------------------------

--- INSERTING MY DATA TO ORDER TABLES--

CREATE PROCEDURE ADDORD (@OI CHAR(7),@OD DATE,@CI CHAR(7),@PI CHAR(7),@OQ INT)
AS
BEGIN
	INSERT INTO ORD
	VALUES (@OI,@OD,@CI,@PI,@OQ);

	SELECT * FROM ORD WHERE OID=@OI;
END;

SELECT * FROM ORD;
--------------------------------------------------------------------------------

--- INSERTING MY DATA TO STOCK TABLES--

CREATE PROCEDURE ADDSTK (@PI CHAR(7),@SQ INT,@ROL INT,@MOQ INT)
AS
BEGIN
	INSERT INTO STK
	VALUES (@PI,@SQ,@ROL,@MOQ);

	SELECT * FROM STK WHERE PID =@PI;
END;
      
SELECT * FROM STK;
--------------------------------------------------------------------------------
--- INSERTING MY DATA TO PURCHASE TABLES--

CREATE PROCEDURE ADDPUR (@PI CHAR(7),@SI CHAR(7),@PQTY INT,@DOP DATE)
AS
BEGIN 
	INSERT INTO PUR
	VALUES (@PI,@SI,@PQTY,@DOP);

	SELECT * FROM PUR WHERE PID =@PI;
END;

SELECT * FROM PUR;

-------------------------------------------------------------------------

-- USING TRIGGER---

CREATE TRIGGER TR_IN_ORD
ON ORD
FOR INSERT
AS
BEGIN
	   UPDATE STK SET SQTY = (SQTY-(SELECT OQTY FROM INSERTED))
	   WHERE PID = (SELECT PID FROM INSERTED);
END;

CREATE TRIGGER TR_IN_PUR
ON STK
FOR INSERT
AS 
BEGIN
	    UPDATE PUR SET PQTY = (SELECT SQTY FROM INSERTED)
		WHERE PID = (SELECT PID FROM INSERTED);
END;
-------------------------------------------------------------------------------






ADDPROD P0001,'LG AC',17000,'HA',S0001;












































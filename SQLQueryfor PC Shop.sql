CREATE TABLE DIM_LOCATION (
    LOCATION_ID INT IDENTITY(1,1) PRIMARY KEY,
    CONTINENT VARCHAR(100),
    COUNTRY_OR_STATE VARCHAR(100),
    PROVINCE_OR_CITY VARCHAR(100)
);

INSERT INTO DIM_LOCATION (CONTINENT, COUNTRY_OR_STATE, PROVINCE_OR_CITY)
SELECT CONTINENT, COUNTRY_OR_STATE, PROVINCE_OR_CITY
FROM [dbo].[pc_data]

#########################################################################################

CREATE TABLE DIM_Store (
    Store_ID INT IDENTITY(1,1) PRIMARY KEY,
    [Shop_Name] VARCHAR(100),
    [Shop_Age] VARCHAR(100),
);

INSERT INTO DIM_Store (Shop_Name, Shop_Age)
SELECT Shop_Name, Shop_Age
FROM [dbo].[pc_data]

##########################################################################################3
     
CREATE TABLE DIM_Product (
    Product_ID INT IDENTITY(1,1) PRIMARY KEY,
    PC_MAKE VARCHAR(100),
    PC_MODEL VARCHAR(100),
    RAM VARCHAR(50),
    STORAGE_CAPACITY VARCHAR(50),
    STORAGE_TYPE VARCHAR(50)
);

INSERT INTO DIM_Product (PC_MAKE, PC_MODEL,RAM,STORAGE_CAPACITY,STORAGE_TYPE)
SELECT PC_MAKE, PC_MODEL,RAM,STORAGE_CAPACITY,STORAGE_TYPE
FROM [dbo].[pc_data]

##############################################################################################

CREATE TABLE DIM_Sales_Person (
    SALES_PERSON_ID INT IDENTITY(1,1) PRIMARY KEY,
    SALES_PERSON_NAME VARCHAR(100),
    SALES_PERSON_DEPARTMENT VARCHAR(100)
);

INSERT INTO DIM_Sales_Person (SALES_PERSON_NAME, SALES_PERSON_DEPARTMENT)
SELECT SALES_PERSON_NAME, SALES_PERSON_DEPARTMENT
FROM [dbo].[pc_data]

#####################################################################################################

CREATE TABLE DIM_DATE(
    DATE_ID INT IDENTITY(1,1) PRIMARY KEY,
    PURCHASE_DATE DATE,
    SHIP_DATE DATE
);

INSERT INTO DIM_DATE (PURCHASE_DATE, SHIP_DATE)
SELECT TRY_CONVERT(DATE, PURCHASE_DATE), TRY_CONVERT(DATE, SHIP_DATE)
FROM [dbo].[pc_data]

###########################################################################################################

CREATE TABLE DIM_CHANNEL(
    Channel_ID INT IDENTITY(1,1) PRIMARY KEY,
    PRIORITY VARCHAR(50),
    CHANNEL VARCHAR(100)
);

INSERT INTO DIM_CHANNEL (PRIORITY, CHANNEL)
SELECT PRIORITY, CHANNEL
FROM [dbo].[pc_data]
    
###############################################################################################################

CREATE TABLE DIM_Customer(
    CUSTOMER_ID INT IDENTITY(1,1) PRIMARY KEY,
    CUSTOMER_NAME VARCHAR(100),
    CUSTOMER_SURNAME VARCHAR(100),
    CUSTOMER_CONTACT_NUMBER VARCHAR(30),
    CUSTOMER_EMAIL_ADDRESS VARCHAR(150),
    CREDIT_SCORE INT
);

INSERT INTO DIM_Customer (CUSTOMER_NAME, CUSTOMER_SURNAME,CUSTOMER_CONTACT_NUMBER,CUSTOMER_EMAIL_ADDRESS,CREDIT_SCORE)
SELECT CUSTOMER_NAME, CUSTOMER_SURNAME,CUSTOMER_CONTACT_NUMBER,CUSTOMER_EMAIL_ADDRESS,CREDIT_SCORE
FROM [dbo].[pc_data]

################################################################################################################

CREATE TABLE FACT_SALES (
    SALES_ID INT IDENTITY(1,1) PRIMARY KEY,
  
    LOCATION_ID INT,
    STORE_ID INT,
    PRODUCT_ID INT,
    DATE_ID INT,
    CHANNEL_ID INT,
    CUSTOMER_ID INT,

    COST_PRICE DECIMAL(12,2),
    SALE_PRICE DECIMAL(12,2),
    PC_MARKET_PRICE DECIMAL(12,2),
    DISCOUNT_AMOUNT DECIMAL(12,2),
    FINANCE_AMOUNT DECIMAL(12,2),
    COST_OF_REPAIRS DECIMAL(12,2),
    TOTAL_SALES_PER_EMPLOYEE DECIMAL(12,2),

    CONSTRAINT FK_FACT_LOCATION FOREIGN KEY (LOCATION_ID) REFERENCES DIM_LOCATION(LOCATION_ID),

    CONSTRAINT FK_FACT_STORE FOREIGN KEY (STORE_ID) REFERENCES DIM_STORE(STORE_ID),

    CONSTRAINT FK_FACT_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES DIM_PRODUCT(PRODUCT_ID),

    CONSTRAINT FK_FACT_DATE FOREIGN KEY (DATE_ID) REFERENCES DIM_DATE(DATE_ID),

    CONSTRAINT FK_FACT_CHANNEL FOREIGN KEY (CHANNEL_ID) REFERENCES DIM_CHANNEL(CHANNEL_ID),

    CONSTRAINT FK_FACT_CUSTOMER FOREIGN KEY (CUSTOMER_ID) REFERENCES DIM_CUSTOMER(CUSTOMER_ID)
);

INSERT INTO FACT_SALES (COST_PRICE,SALE_PRICE,PC_MARKET_PRICE,DISCOUNT_AMOUNT,FINANCE_AMOUNT,COST_OF_REPAIRS,TOTAL_SALES_PER_EMPLOYEE)
SELECT COST_PRICE,SALE_PRICE,PC_MARKET_PRICE,DISCOUNT_AMOUNT,FINANCE_AMOUNT,COST_OF_REPAIRS,TOTAL_SALES_PER_EMPLOYEE
FROM [dbo].[pc_data]

############################################################################################################################


EXEC [dbo].[SP_Truncate_Fact_Data]
EXEC [dbo].[SP_Populate_Fact_Sales_Data]
EXEC [dbo].[SP_Truncate_DIM_Store]
EXEC [dbo].[SP_Insert_Data_DIM_Store]
EXEC [dbo].[SP_Truncate_DIM_Product]
EXEC [dbo].[SP_Populate_Data_DIM_Product]
EXEC [dbo].[SP_Truncate_DIM_LOCATION]
EXEC [dbo].[SP_Insert_Data_DIM_LOCATION]
EXEC [dbo].[SP_Truncate_DIM_DATE]
EXEC [dbo].[SP_Populate_Data_DIM_DATE]
EXEC [dbo].[SP_Truncate_DIM_Customer]
EXEC [dbo].[SP_Populate_Data_DIM_Customer]
EXEC [dbo].[SP_Truncate_DIM_CHANNEL]
EXEC [dbo].[SP_Populate_Data_DIM_CHANNEL]
EXEC 





SELECT *
  FROM [PC_Stores].[dbo].[DIM_CHANNEL]

SELECT *
  FROM [PC_Stores].[dbo].[FACT_SALES]

SELECT *
  FROM [PC_Stores].[dbo].DIM_Store

SELECT *
  FROM [PC_Stores].[dbo].[DIM_LOCATION]

SELECT *
  FROM [PC_Stores].[dbo].DIM_Customer

SELECT *
  FROM [PC_Stores].[dbo].DIM_Product

SELECT *
  FROM [PC_Stores].[dbo].DIM_DATE

SELECT *
  FROM [PC_Stores].[dbo].DIM_Sales_Person
  

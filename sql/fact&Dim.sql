CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    CustomerCategoryID INT,
    BuyingGroupID INT,
    PhoneNumber NVARCHAR(20),
    FaxNumber NVARCHAR(20),
    WebsiteURL NVARCHAR(256),
    CreditLimit DECIMAL(18, 2),
    AccountOpenedDate DATE,
    IsOnCreditHold BIT
);


CREATE TABLE DimProduct (
    StockItemID INT PRIMARY KEY,
    StockItemName NVARCHAR(100),
    ColorID INT,
    Brand NVARCHAR(50),
    Size NVARCHAR(20),
    QuantityPerOuter INT,
    TaxRate DECIMAL(18, 3),
    UnitPrice DECIMAL(18, 2),
    RecommendedRetailPrice DECIMAL(18, 2)
);


CREATE TABLE DimEmployee (
    PersonID INT PRIMARY KEY,
    FullName NVARCHAR(50),
    PreferredName NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    FaxNumber NVARCHAR(20),
    EmailAddress NVARCHAR(256),
    IsSalesperson BIT
);


CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,             -- Format: YYYYMMDD
    Date DATE NOT NULL,
    Day INT NOT NULL,
    Month INT NOT NULL,
    MonthName NVARCHAR(20),
    Quarter INT NOT NULL,
    Year INT NOT NULL,
    WeekOfYear INT,
    DayOfWeek INT,
    DayName NVARCHAR(20),
    IsWeekend BIT
);


DECLARE @StartDate DATE = '2013-01-01';
DECLARE @EndDate DATE = '2016-05-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey,
        Date,
        Day,
        Month,
        MonthName,
        Quarter,
        Year,
        WeekOfYear,
        DayOfWeek,
        DayName,
        IsWeekend
    )
    VALUES (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate),
        DATEPART(WEEK, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        CASE WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;


CREATE TABLE FactOrder (
    OrderLineID INT PRIMARY KEY,
    OrderID INT,
    StockItemID INT,
    CustomerID INT,
    PersonID INT, -- from Application.People
    Quantity INT,
    UnitPrice DECIMAL(18, 2),
    TaxRate DECIMAL(18, 3),
    PickedQuantity INT,
    PickingCompletedWhen DATETIME2(7),
    OrderDate DATE, -- from Sales.Orders (if needed)
    accm_txn_create_time DATETIME2(7), -- for accumulating snapshot
    accm_txn_complete_time DATETIME2(7),
    txn_process_time_hours INT
);

DROP TABLE DimCustomer;
DROP TABLE DimEmployee;
DROP TABLE DimProduct;
DROP TABLE DimDate;
DROP  TABLE FactOrder;

-- Customer → DimCustomer
ALTER TABLE FactOrder
ADD CONSTRAINT FK_FactOrder_DimCustomer
FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID);

-- Product → DimProduct
ALTER TABLE FactOrder
ADD CONSTRAINT FK_FactOrder_DimProduct
FOREIGN KEY (StockItemID) REFERENCES DimProduct(StockItemID);

-- Employee/Person → DimEmployee
ALTER TABLE FactOrder
ADD CONSTRAINT FK_FactOrder_DimEmployee
FOREIGN KEY (PersonID) REFERENCES DimEmployee(PersonID);


ALTER TABLE FactOrder
ADD CONSTRAINT FK_FactOrder_DimDate
FOREIGN KEY (OrderDate) REFERENCES DimDate(Date);




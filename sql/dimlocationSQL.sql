use [WideWorld_staging ]
go

CREATE TABLE StgLocation (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    DeliveryAddressLine1 NVARCHAR(60),
    DeliveryAddressLine2 NVARCHAR(60),
    DeliveryPostalCode NVARCHAR(10),
    DeliveryCityID INT,
    PostalAddressLine1 NVARCHAR(60),
    PostalAddressLine2 NVARCHAR(60),
    PostalPostalCode NVARCHAR(10),
    PostalCityID INT
);



ALTER TABLE DimCustomer
ADD LocationID INT;

ALTER TABLE dbo.DimCustomer
DROP COLUMN LocationID;


use [WideWorld_staging ]; 
go

INSERT INTO dbo.StgLocation(
    DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, DeliveryCityID,
    PostalAddressLine1, PostalAddressLine2, PostalPostalCode, PostalCityID
)
SELECT DISTINCT
    DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, DeliveryCityID,
    PostalAddressLine1, PostalAddressLine2, PostalPostalCode, PostalCityID
FROM [WideWorld_staging ].dbo.stgCustomers


ALTER TABLE dbo.StgCustomers
DROP COLUMN
    DeliveryAddressLine1,
    DeliveryAddressLine2,
    DeliveryPostalCode,
    DeliveryCityID,
    PostalAddressLine1,
    PostalAddressLine2,
    PostalPostalCode,
    PostalCityID;




DROP DATABASE IF EXISTS ups_tracking_system;
CREATE DATABASE ups_tracking_system;
USE ups_tracking_system;

CREATE TABLE RetailCenter (
    CenterID INT PRIMARY KEY,
    Type VARCHAR(50),
    Address VARCHAR(100)
);

CREATE TABLE TransportationEvent (
    ScheduleNumber INT PRIMARY KEY,
    Type VARCHAR(30),
    DeliveryRoute VARCHAR(100)
);

CREATE TABLE ShippedItem (
    ItemNumber INT PRIMARY KEY,
    Weight DECIMAL(6,2),
    Dimensions VARCHAR(50),
    InsuranceAmount DECIMAL(10,2),
    Destination VARCHAR(100),
    FinalDeliveryDate DATE,
    CenterID INT,
    FOREIGN KEY (CenterID) REFERENCES RetailCenter(CenterID)
);

CREATE TABLE ItemTransportation (
    ItemNumber INT,
    ScheduleNumber INT,
    PRIMARY KEY (ItemNumber, ScheduleNumber),
    FOREIGN KEY (ItemNumber) REFERENCES ShippedItem(ItemNumber),
    FOREIGN KEY (ScheduleNumber) REFERENCES TransportationEvent(ScheduleNumber)
);

DROP DATABASE IF EXISTS production_tracking_system;
CREATE DATABASE production_tracking_system;
USE production_tracking_system;

CREATE TABLE Lot (
    LotNumber INT PRIMARY KEY,
    CreateDate DATE,
    CostOfMaterials DECIMAL(10,2)
);

CREATE TABLE RawMaterial (
    MaterialID INT PRIMARY KEY,
    Type VARCHAR(50),
    UnitCost DECIMAL(8,2)
);

CREATE TABLE ProductionUnit (
    SerialNumber INT PRIMARY KEY,
    ExactWeight DECIMAL(6,2),
    ProductType VARCHAR(50),
    ProductDesc VARCHAR(100),
    QualityTest VARCHAR(20),
    LotNumber INT,
    FOREIGN KEY (LotNumber) REFERENCES Lot(LotNumber)
);

CREATE TABLE LotRawMaterial (
    LotNumber INT,
    MaterialID INT,
    Units INT,
    PRIMARY KEY (LotNumber, MaterialID),
    FOREIGN KEY (LotNumber) REFERENCES Lot(LotNumber),
    FOREIGN KEY (MaterialID) REFERENCES RawMaterial(MaterialID)
);
-------------------------------------------------
-- Start of Coding
-------------------------------------------------

CREATE DATABASE Group_5_RideNow;
USE Group_5_RideNow;;


-------------------------------------------------
-- Create table statements
-------------------------------------------------

CREATE TABLE ServiceUser
	(
	UserID varchar(45) NOT NULL PRIMARY KEY,
	Password varchar(45) NOT NULL,
	EMailID varchar(45) NOT NULL,
	Name varchar(45) NOT NULL,
	PhoneNo varchar(45) NOT NULL,
	LicenseID varchar(45) NOT NULL,
	Address varchar(45) NOT NULL,
	YearsOfMemebership INT NOT NULL,
	hasReservation TINYINT NOT NULL
	);

/* Creating a Table with Table level Check Constraint */
CREATE TABLE Promotions
	(
	PromotionCode varchar(45) NOT NULL PRIMARY KEY,
	OfferName varchar(45) NOT NULL,
	ValidityDate DATE NOT NULL,
	PromotionValue INT NOT NULL,
	CHECK(Promotions.OfferName IN ('NewYears','XMas')),
	CHECK(Promotions.OfferName<> 'NewYears' OR	Promotions.PromotionValue=1200)
	);

CREATE TABLE Refunds
	(
	RefundID varchar(45) NOT NULL PRIMARY KEY,
	RefundDate DATE NOT NULL,
	RefundAmount INT NOT NULL,
	RefundReason varchar(45),
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID)
	);	

CREATE TABLE Payments
	(
	CardNo varchar(45) NOT NULL PRIMARY KEY,
	PaymentAmount INT NOT NULL,
	CardHolderName varchar(45) NOT NULL,
	ExpiryDate DATE NOT NULL,
	CVV varchar(45) NOT NULL,
	CardType varchar(45) NOT NULL,
	IsPrimaryCard TINYINT NOT NULL,
	PaymentStatus varchar(45) NOT NULL,
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID)
	);

CREATE TABLE RentalHistory
	(
	FromPoint varchar(60) NOT NULL,
	ToPoint varchar(60) NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	MilesDriven INT NOT NULL,
	BillAmount INT NOT NULL,
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID)
	);


CREATE TABLE CarPurchase
	(
	PurchaseID varchar(45) NOT NULL UNIQUE,
	RegistrationNo varchar(45) NOT NULL,
	PurchaseDate DATE NOT NULL,
	PurchaseAmount INT NOT NULL,
	PurchaseType varchar(45) NOT NULL,
	PRIMARY KEY(RegistrationNo)
	);

CREATE TABLE Fleet
	(
	Make varchar(45) NOT NULL,
	Type varchar(45) NOT NULL,
	Color varchar(45) NOT NULL,
	OdometerReading varchar(45) NOT NULL,
	IsReserved TINYINT NOT NULL,
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID),
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo),
	PRIMARY KEY(RegistrationNo)
	);

CREATE TABLE FleetTelematics
	(
	Latitude FLOAT NOT NULL,
	Longitude FLOAT NOT NULL,
	FuelLevel FLOAT NOT NULL,
	MilesRemaining FLOAT NOT NULL,
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID),
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo),
	PRIMARY KEY(RegistrationNo)
	);

CREATE TABLE Accidents
	(
	IncidentDateTime DATETIME NOT NULL PRIMARY KEY,
	IncidentLocation varchar(45) NOT NULL,
	Status varchar(45) NOT NULL,
	UserID varchar(45) NOT NULL FOREIGN KEY REFERENCES ServiceUser(UserID),
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo)
	);

CREATE TABLE Gadgets
	(
	BluetoothAvailability TINYINT NOT NULL,
	GPSTracker TINYINT NOT NULL,
	RearCameraAvailability TINYINT NOT NULL,
	USBChargingAvailability TINYINT NOT NULL,
	DashCameraAvailability TINYINT NOT NULL,
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo),
	PRIMARY KEY(RegistrationNo)
	);

CREATE TABLE Insurance
	(
	InsuranceID varchar(45) NOT NULL PRIMARY KEY,
	InsuranceCompany varchar(45) NOT NULL,
	TotalPaymentAmount INT NOT NULL,
	PaymentRemaining INT NOT NULL,
	LastClaimedAmount INT NOT NULL,
	ClaimReason varchar(45) NOT NULL,
	NextDueDate DATE NOT NULL,
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo)
	);

CREATE TABLE Service
	(
	DateOfService DATE NOT NULL,
	ServiceType varchar(45) NOT NULL,
	LastServiceAmount INT NOT NULL,
	LastServiceAvailed varchar(45) NOT NULL,
	LastServiceDate DATE NOT NULL,
	RegistrationNo varchar(45) NOT NULL FOREIGN KEY REFERENCES CarPurchase(RegistrationNo),
	PRIMARY KEY(RegistrationNo)
	);

-------------------------------------------------
-- Insert statements
-------------------------------------------------

INSERT INTO ServiceUser(UserID, Password, EMailID, Name, PhoneNo, LicenseID, Address, YearsOfMemebership, hasReservation)
	VALUES
	('121', 'abcd', 'ab@xyz.com', 'Jake', '13231', '3432', '123 NAve Wa', 4, 1),
	('122', 'cdef', 'cd@xyz.com', 'John', '1456', '8789', '124 NAve WA', 3, 1),
	('123', 'fdfd', 'ij@xyz.com', 'iris', '1567', '211','124 NAve WA', 3, 1),
	('124', 'abhy', 'st@xyz.com', 'Jack', '19879','672', '125 NAve WA', 2, 1),
	('125', 'rtyu', 'sd@xyz.com', 'Kim', '146423', '4554','124 NEAve WA', 3, 1),
	('126', 'werty', 'yu@xyz.com', 'Jimmy', '97897', '090','125 NEAve WA', 2, 1),
	('127', 'ioioip', 'py@xyz.com', 'PY', '657578', '556','124 SWAve WA', 3, 1),
	('128', 'uyuyui', 'ui@xyz.com', 'UI', '1456', '8768','126 WAve WA', 1, 1),
	('129', 'qweyk', 'qw@xyz.com', 'Qu', '1456', '5454','126 SAve WA', 3, 1),
	('130', 'iuopmk', 'hu@xyz.com', 'HU', '1456', '878', '127 SAve WA', 3, 1);

INSERT INTO Promotions(PromotionCode, OfferName, ValidityDate, PromotionValue)
	VALUES
	('111', 'NewYears', '11/21/2017', 1200),
	('112', 'NewYears', '11/22/2017', 1200),
	('113', 'NewYears', '11/23/2017', 1200),
	('114', 'XMas', '11/23/2017', 1900),
	('115', 'NewYears', '11/25/2017', 1200),
	('116', 'XMas', '11/26/2017', 1800),
	('117', 'XMas', '11/27/2017', 1100),
	('118', 'NewYears', '11/28/2017', 1200),
	('119', 'XMas', '11/22/2017', 1300),
	('120', 'NewYears', '11/23/2017', 1200);

INSERT INTO Refunds(RefundID, RefundDate, RefundAmount, RefundReason, UserID)
	VALUES
	('51', '10-19-2017', 60, 'No Service Availed', '122'),
	('52', '10-20-2017', 40, 'Car Malfunction', '123'),
	('53', '10-21-2017', 30, 'Other', '122'),
	('54', '11-19-2017', 10, 'No Service Availed', '124'),
	('55', '11-20-2017', 40, 'No Service Availed', '125'),
	('56', '11-19-2017', 60, 'No Service Availed', '126'),
	('57', '11-19-2017', 10, 'No Service Availed', '122'),
	('58', '11-20-2017', 22, 'No Service Availed', '127'),
	('59', '11-21-2017', 23, 'No Service Availed', '123'),
	('60', '11-22-2017', 34, 'No Service Availed', '125');

INSERT INTO Payments(CardNo, PaymentAmount, CardHolderName, ExpiryDate, CVV, CardType, IsPrimaryCard, PaymentStatus, UserID)
	VALUES
	('110', 30, 'John', '10/21/2020', '123', 'Credit', 1, 'Paid', '122'),
	('111', 130, 'Ken', '01/20/2020', '13', 'Debit', 1, 'Paid', '122'),
	('112', 340, 'Iris', '12/12/2020', '11', 'Credit', 1, 'Paid', '123'),
	('113', 310, 'Jin', '09/19/2020', '23', 'Debit', 1, 'Paid', '122'),
	('114', 310, 'Frank', '02/18/2020', '121', 'Credit', 1, 'Paid', '124'),
	('115', 310, 'Kim', '07/12/2020', '113', 'Debit', 1 ,'Paid', '125'),
	('116', 130, 'Harry', '04/10/2020', '131', 'Credit', 1, 'Paid', '123'),
	('117', 304, 'Pat', '03/01/2020', '103', 'Credit', 1, 'Paid', '127'),
	('118', 305, 'Rebacca', '01/21/2020', '023', 'Debit', 1, 'Paid', '128'),
	('119', 301, 'Marry', '02/21/2020', '13', 'Credit', 1, 'Paid', '129');
	
	
INSERT INTO RentalHistory(FromPoint , ToPoint , StartTime , EndTime , MilesDriven ,BillAmount , UserID )
	VALUES 
	('California' , 'Chicago', '06:20', '09:20', '2195', '2000','121' ),
	('Seattle' , 'Alabama', '09:00', '12:16', '195', '1244','122' ),
	('New York' , 'Denver', '13:10', '06:10', '1105', '544','123' ),
	('Los Angeles' , 'San Jose', '04:05', '02:20', '1050', '8623','124' ),
	('Washington DC' , 'Detroit', '05:08', '09:09', '768', '123','125' ),
	('Boston' , 'New Orleans', '03:45', '06:10', '987', '765','126' ),
	('Houston' , 'Miami', '02:20', '04:11', '456', '982','127' ),
	('Austin' , 'Atlanta', '06:10', '08:30', '123', '1244','128' ),
	('Dallas' , 'Portland', '03:17', '11:50', '453', '1240','129' ),
	('Phoenix' , 'Memphis', '03:20', '10:20', '675', '679','130' );
	
INSERT INTO CarPurchase	(PurchaseID, RegistrationNo, PurchaseDate, PurchaseAmount, PurchaseType)
	VALUES 
	('P01', 'TXF101', '11/21/1994', 121231, 'Paid_By_Card' ),
	('P02', 'XYZ671', '11/01/1994', 12344, 'Paid_By_Cash'),
	('P03', 'KYQ10', '01/21/2001', 45121, 'Paid_Using_EMI'),
	('P04', 'RAC829', '09/21/2014', 132561, 'Paid_By_Card'),
	('P05', 'DOP391', '01/21/1992', 633124, 'Paid_By_Check'),
	('P06', 'CHR451', '02/12/2000', 742136, 'Paid_Thru_Online'),
	('P07', 'DOF134', '08/21/1976', 12334, 'Paid_Using_EMI'),
	('P08', 'DAF187', '02/21/1986', 2154, 'Paid_By_Cash'),
	('P09', 'DEX056', '03/21/2017', 53445, 'Paid_By_Check'),
	('P10', 'MER452', '09/21/2015', 42423, 'Paid_Thru_Online');
	
INSERT INTO Fleet(Make, Type , Color , OdometerReading , IsReserved , UserID , RegistrationNo )
	VALUES 
	('Toyato', 'Economy', 'Silver','105341', '0', '121', 'TXF101'),
	('Holden', 'Standard','Gold', '6767', 	'1',  '122', 'XYZ671'),
	('Ford',   'SUV', 'Black',	  '2324', 	'0', '123', 'KYQ10'), 
	('Nissan', 'MiniVan', 'Gold', '23443', 	'1', '124', 'RAC829'),
	('BMW',    'Premium', 'White', '464232', '0',  '125', 'DOP391'),
	('Audi',   'Economy', 'Red','3267', 	'1', '126', 'CHR451'),
	('Kia',    'Standard', 'JetBlue',  '2434', 	'0',  '127',  'DOF134'),
	('Hyundia', 'SUV', 'SkyBlue',	   '54346', '1', '128',  'DAF187'),
	('Tata',	'MiniVan', 'IceBlue','45353',	'0',  '129',  'DEX056'),
	('Volvo', 	'Economy','Yellow', '3456',	'1',  '130', 'MER452');
	
INSERT INTO FleetTelematics(Latitude, Longitude , FuelLevel , MilesRemaining , UserID , RegistrationNo )
	VALUES 
	('51.5678', '8392.23', '42', '98', '121', 'TXF101'),
	('41.876', '211.423', '52', '56', '122', 'XYZ671'),
	('37.678', '122.63', '62', '12', '123', 'KYQ10'),
	('21.234', '332.43', '41', '81', '124', 'RAC829'),
	('10.678', '892.13', '64', '12', '125', 'DOP391'),
	('78.348', '312.353', '132','12', '126', 'CHR451'),
	('12.246', '196.123', '562','89', '127', 'DOF134'),
	('78.178', '802.33', '422', '12', '128', 'DAF187'),
	('32.267', '1292.23', '242','54', '129', 'DEX056'),
	('22.278', '302.21', '222', '67', '130', 'MER452');
	
INSERT INTO Accidents(IncidentDateTime, IncidentLocation , Status , UserID , RegistrationNo )
	VALUES 
	('11/21/2020','Chicago','Closed',  '121', 'TXF101'),
	('11/20/2010','Seattle', 'InProgress', '122', 'XYZ671'),
	('12/12/2020','California','Open', '123', 'KYQ10'),
	('09/19/2020','Alabama','Hold','124', 'RAC829'),
	('02/18/2020','Miami','Closed','125', 'DOP391'),
	('07/12/2020','Memphis','InProgress','126', 'CHR451'),
	('04/10/2020','Holden','Open','127', 'DOF134'),
	('03/01/2020','Nevada','Hold','128', 'DAF187'),
	('01/21/2012','Seattle','Closed','129', 'DEX056'),
	('02/21/2020','Missori','InProgress', '130', 'MER452');
		
	
INSERT INTO Gadgets(BluetoothAvailability, GPSTracker , RearCameraAvailability , USBChargingAvailability , DashCameraAvailability , RegistrationNo )
	VALUES 
	('1', '0', '1', '0', '1',  'TXF101'),
	('0', '1', '0', '1', '1',  'XYZ671'),
	('1', '0', '1', '1', '1',  'KYQ10'),
	('1', '1', '1', '0', '1',  'RAC829'),
	('0', '1', '1', '1', '1',  'DOP391'),
	('1', '0', '1', '1', '1', 'CHR451'),
	('0', '1', '0', '0', '1',  'DOF134'),
	('1', '0', '1', '1', '1', 'DAF187'),
	('0', '0', '1', '0', '1',  'DEX056'),
	('1', '1', '1', '1', '1',  'MER452');
	
INSERT INTO Insurance(InsuranceID, InsuranceCompany , TotalPaymentAmount , PaymentRemaining , LastClaimedAmount , ClaimReason , NextDueDate, RegistrationNo )
	VALUES 
	('I001', 'ABC', '6733', '211', '212', 'Nil', '11/27/2017', 'TXF101'),
	('I002', 'CDS', '6133', '212', '2112', 'Nil', '11/23/2017', 'XYZ671'),
	('I003', 'AHS', '7333', '214', '112', 'Nil', '11/30/2017', 'KYQ10'),
	('I004', 'ASK', '7334', '212', '1412', 'Nil', '02/25/2017', 'RAC829'),
	('I005', 'ASI', '6233', '213', '4212', 'Nil', '04/02/2017', 'DOP391'),
	('I006', 'UHG', '1313', '216', '2112', 'Nil', '10/01/2017', 'CHR451'),
	('I007', 'ABC', '32433', '261', '412', 'Nil', '10/01/2017', 'DOF134'),
	('I008', 'BJU', '654', '217', '223', 'Nil', '12/03/2017', 'DAF187'),
	('I009', 'POT', '6353', '111', '452', 'Nil', '06/02/2017', 'DEX056'),
	('I010', 'CAT', '6533', '811', '3532', 'Nil', '07/11/2017', 'MER452');
	
INSERT INTO Service	(DateOfService, ServiceType , LastServiceAmount , LastServiceAvailed , LastServiceDate , RegistrationNo)
	VALUES 
	('11/27/2017', 'Off-Exchange', '123', '211', 'Dec 2013', 'TXF101'),
	('11/23/2017', 'Qualified', '23424','123', 'Jan 2017',	'XYZ671' ),
	('11/30/2017', 'Catastropic','244', '124', 'Mar 2014', 'KYQ10'),
	('02/25/2017', 'LongTerm', '234','2423', 'Apr 2012', 	'RAC829'),
	('04/02/2017', 'ShortTerm','6642','23545', 'May 2010',	'DOP391' ),
	('10/01/2017', 'Off-Exchange','243', '43456', 'Jun 2010', 'CHR451'),
	('10/01/2017', 'Qualified', '567','355', 'Jul 2011', 	'DOF134'),
	('12/03/2017', 'Catastropic','1245','56767', 'Apr 2013', 'DAF187'),
	('06/02/2017', 'LongTerm','6775', '75554', 'Aug 2016', 'DEX056'),
	('07/11/2017', 'ShortTerm','2234', '8342', 'Apr 2017', 'MER452');
	

-------------------------------------------------
-- View statements
-------------------------------------------------


SELECT        
dbo.ServiceUser.UserID AS UserNumber, 
dbo.ServiceUser.Name,
dbo.Fleet.Make AS FleetMake, 
dbo.Fleet.Type AS FleetType, 
dbo.Fleet.Color AS FleetColor, 
dbo.Fleet.OdometerReading AS FleetOdometerReading, 
dbo.Fleet.IsReserved AS FleetIsReserved
--dbo.Fleet.*
FROM dbo.Fleet INNER JOIN
dbo.ServiceUser ON dbo.Fleet.UserID = dbo.ServiceUser.UserID


GO
CREATE VIEW AccidentDetails AS
SELECT     
dbo.Accidents.IncidentDateTime, 
dbo.Accidents.IncidentLocation, 
dbo.Accidents.UserID, 
dbo.Accidents.RegistrationNo
FROM            
dbo.Accidents INNER JOIN
dbo.CarPurchase 
ON dbo.Accidents.RegistrationNo = dbo.CarPurchase.RegistrationNo

GO
CREATE VIEW PromotionsAvailedByUser AS
SELECT        
dbo.Fleet.UserID, 
dbo.ServiceUser.Name,
dbo.Promotions.PromotionCode, 
dbo.Promotions.OfferName, 
dbo.Promotions.ValidityDate, 
dbo.Promotions.PromotionValue 
FROM            
dbo.Fleet INNER JOIN
dbo.ServiceUser ON dbo.Fleet.UserID = dbo.ServiceUser.UserID CROSS JOIN
dbo.Promotions

-------------------------------------------------
-- Implementation of Column Level Encryption
-------------------------------------------------
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Encrypt_P@sswOrd';

CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';

CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

ALTER TABLE ServiceUser ADD EncPassword varbinary(200);

UPDATE ServiceUser
SET EncPassword =EncryptByKey(Key_GUID(N'TestSymmetricKey'),Password);

SELECT * FROM ServiceUser
--------------------------------------------------------------------
-- Validating the Table Level Check Constraint - 1 Implementation
--------------------------------------------------------------------
INSERT INTO Promotions(PromotionCode, OfferName, ValidityDate, PromotionValue)
	VALUES('121', 'NewYears', '11/21/2017', 1300);


--------------------------------------------------------------------
-- Check Constraint - 2 Implementation
--------------------------------------------------------------------
CREATE FUNCTION CheckPaymentStatus(@UserID varchar(45))
RETURNS smallint
AS
BEGIN
	 DECLARE @Count smallint=0;
	 SELECT @Count = COUNT(UserID)
	 FROM Payments
	 WHERE UserID = @UserID
	 AND PaymentStatus = 'Not Paid';
     RETURN @Count;
END;

ALTER TABLE Fleet ADD CONSTRAINT BlockReservation CHECK(dbo.CheckPaymentStatus(UserID)=0);

INSERT INTO CarPurchase(PurchaseID, RegistrationNo, PurchaseDate, PurchaseAmount, PurchaseType)
	VALUES('167', 'TS123', '11/21/2016', 30000, 'New');
INSERT INTO  CarPurchase(PurchaseID, RegistrationNo, PurchaseDate, PurchaseAmount, PurchaseType)		  
	VALUES('168', 'TS124', '11/21/2016', 30000, 'New');
INSERT INTO Fleet(Make, Type, Color, OdometerReading, IsReserved, UserID, RegistrationNo)
	VALUES ('BMW', 'Coupe', 'Black', '1500', '1', '121', 'TS123');
INSERT INTO Payments(CardNo, PaymentAmount, CardHolderName, ExpiryDate, CVV, CardType, IsPrimaryCard, PaymentStatus, UserID)
	VALUES('121', 30, 'Jake', '11/21/2020', '123', 'Credit', 1 , 'Not Paid', '123');

--------------------------------------------------------------------
-- Validating Check Constraint - 2 Implementation 
--------------------------------------------------------------------

INSERT INTO Fleet(Make, Type, Color, OdometerReading, IsReserved, UserID, RegistrationNo)
	VALUES ('BMW', 'Coupe', 'Black', '1500', '1', '123', 'TS124');


-------------------------------------------------
-- End of Coding
-------------------------------------------------











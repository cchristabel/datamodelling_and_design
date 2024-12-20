CREATE DATABASE Banken
GO

USE Banken
GO

/* Creating Customer Table
   Which is our Parent Table
*/

CREATE TABLE Customer
(
CustomerID INT IDENTITY(6006,1) PRIMARY KEY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Gender NVARCHAR(10) NOT NULL,
PersonalNumber VARCHAR(12) NOT NULL,
DateOfBirth DATE NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
Email VARCHAR(100) NOT NULL
);
GO

/* Creating LogIn table
Since LogIn is a keyword i'm using LogIns instead
    CustomerID: FOREIGN KEY with one to one relationship for security
*/

CREATE TABLE LogIns
(
LogInID INT IDENTITY(5000,1) PRIMARY KEY,
CustomerID INT NOT NULL,
CONSTRAINT FK_LogIns_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT UQ_CustomerID UNIQUE(CustomerID),
LoginPassword NVARCHAR(10) NOT NULL
);
GO


/* Creating CustomerAddress table 
    CustomerID: FOREIGN KEY with one to many relationship
*/

CREATE TABLE CustomerAddress
(
CustomerAddressID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT NOT NULL,
CONSTRAINT FK_CustomerAddress_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
StreetName NVARCHAR(50) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZipCode NVARCHAR(6) NOT NULL
);
GO


/* Creating AccountType table. 
This table shows whether the account is a Savings account or Checking account.
*/

CREATE TABLE AccountType
(
AccountTypeID INT IDENTITY(20,1) PRIMARY KEY,
AccountTypeName NVARCHAR(30) NOT NULL
);
GO


/* Creating Account table 
    AccountTypeID: FOREIGN KEY with a one to many relationship
	Balance: Amount the customer has in the account before any pending charges are added
	Available: Amount the customer has minus all pending charges
*/

CREATE TABLE Account
(
AccountID INT IDENTITY(100,100) PRIMARY KEY,
AccountTypeID INT NOT NULL,
CONSTRAINT FK_Account_AccountType FOREIGN KEY (AccountTypeID) REFERENCES AccountType(AccountTypeID),
AccountNumber VARCHAR(20) NOT NULL,
Balance MONEY NOT NULL,
Available MONEY NOT NULL,
DateCreated DATETIME NOT NULL
);
GO


/* Creating CardSecurity Table
Putting sensitive information into a seperate table for security
*/

CREATE TABLE CardSecurity
(
CardSecurityID INT IDENTITY(30,1) PRIMARY KEY,
CardNumber NVARCHAR (20) NOT NULL,
CVC INT NOT NULL
);
GO

/* Creating the Card table, since Card is a keyword i made it Cards instead. 
    CardSecurity: FOREIGN KEY with one to one relationship because only authorised people can access the CardSecurity table
	CardType: Shows if the card is Debit card or Credit card
    CardDescrition: Describes if the CardType is a Visa card or Mastercard
*/

CREATE TABLE Cards
(
CardID INT IDENTITY(400,1) PRIMARY KEY,
CardSecurityID INT NOT NULL,
CONSTRAINT FK_Cards_CardSecurity FOREIGN KEY (CardSecurityID) REFERENCES CardSecurity(CardSecurityID),
CONSTRAINT UQ_CardSecurityID UNIQUE(CardSecurityID),
CardType NVARCHAR(20) NOT NULL,
CardTypeDescription NVARCHAR(12) NOT NULL,
IssuedDate DATETIME NOT NULL,
ExpiryMonth TINYINT NOT NULL,
ExpiryYear SMALLINT NOT NULL
);
GO

/* Creating the Dispostions table which is a bridge table for 
    Customer FOREIGN KEY
    Account FOREIGN KEY
    Cards FOREIGN KEY
*/

CREATE TABLE Dispositions
(
DispositionsID INT IDENTITY(111,111) PRIMARY KEY,
CustomerID INT NOT NULL,
CONSTRAINT FK_Dispositions_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
AccountID INT NOT NULL,
CONSTRAINT FK_Dispositions_Account FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
CardID INT NOT NULL,
CONSTRAINT FK_Dispositions_Cards FOREIGN KEY (CardID) REFERENCES Cards(CardID)
);
GO


/* Creating the LoanType table. 
This table shows what type of loan has been applied for 
    LoanType: Private loan
              Mortgage loan
	    	  Student loan 
		      Business loan
*/

CREATE TABLE LoanType
(
LoanTypeID INT IDENTITY(50,1) PRIMARY KEY,
LoanTypeName NVARCHAR(50) NOT NULL
);
GO

/* Creating the Loan table.
    LoanType: FOREIGN KEY with one to many relationship and 
    AccountID: FOREIGN KEY with one to many relationships
    LoanAmount: How much loan has been granted
    LoanDate: When the loan was deposited into the account
    AmountPaid: How much of the loan has been paid by the customer
    Debt: How much of the loan is left to be paid by the customer
    FinalPaymentDate: When the laon has to be fully paid by the customer
*/

CREATE TABLE Loan
(
LoanID INT IDENTITY(600,1) PRIMARY KEY,
AccountID INT NOT NULL,
CONSTRAINT FK_Loan_Account FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
LoanTypeID INT NOT NULL,
CONSTRAINT FK_Loan_LoanType FOREIGN KEY (LoanTypeID) REFERENCES LoanType(LoanTypeID),
LoanNumber VARCHAR(7) NOT NULL,
LoanAmount MONEY NOT NULL,
LoanDate DATE NOT NULL,
AmountPaid MONEY NOT NULL,
Debt MONEY NOT NULL,
FinalPaymentDate DATE NOT NULL
);
GO

/* Creating TransactionType table. 
    TransactionTypeName: Deposits, 
	                     Cash withdrawals
						 Online payments
						 Debit card charges
						 LoanPayment
*/

CREATE TABLE TransactionType
(
TransactionTypeID INT IDENTITY(70,1) PRIMARY KEY,
TransactionTypeName NVARCHAR(30) NOT NULL
);
GO

/*Creating Transaction table but naming it Transactions because Transaction is a keyword. 
    TransactionType: FOREIGN KEY with one to many relationship
	AccountID: FOREIGN KEY with one to many relationship
*/

CREATE TABLE Transactions
(
TransactionID INT IDENTITY(800,1) PRIMARY KEY,
TransactionTypeID INT NOT NULL,
CONSTRAINT FK_Transactions_TransactionType FOREIGN KEY (TransactionTypeID) REFERENCES TransactionType(TransactionTypeID),
AccountID INT NOT NULL,
CONSTRAINT FK_Transactions_Account FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
TransactionDate DATETIME NOT NULL,
TransactionAmount MONEY NOT NULL
);
GO


----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------


-----Inserting data into the Customer table------
-----Inserting data into the Customer table------

INSERT INTO Customer(FirstName,LastName,Gender,PersonalNumber,DateOfBirth,PhoneNumber,Email)
VALUES
('Christabel','Olsson','Female','980815-5624','1998-08-15','0751426754','christabelolsson@gmail.de'),
('Akosua','Eriksson','Female','950227-6378','1995-03-27','0762893528','akosuaeriksson@gmail.de'),
('Jeffery','Olsson','Male','131119-8267','2013-11-19','0792739273','jefferyolsson@gmail.de'),
('Ryan','Olsson','Male','161217-9374','2016-12-17','0763826749','ryanaolsson@gmail.de'),
('Angelina','Berg','Female','940115-2849','1994-01-15','0723456789','angelinaberg@gmail.de'),
('Abena','Gustafsson','Female','980213-6478','1998-02-13','0793857296','abenagustafsson@gmail.de'),
('Shulammite','Johansson','Female','980212-3675','1998-02-12','0736478593','shulammitejohansson@gmail.de'),
('Amy','Forsberg','Female','940908-3564','1994-09-08','0785736498','amyforsberg@gmail.de'),
('Karim','Lindström','Male','950303-3867','1995-03-03','0784657392','karimlindstrom@gmail.de'),
('Karli','Björklund','Male','880720-5624','1988-07-20','0763728396','larlibjorklund@gmail.de'),
('Aseda','Eriksson','Male','200430-7365','2020-04-30','0727368999','asedaeriksson@gmail.de'),
('Eric','Axelsson','Male','990628-6375','1999-06-28','0734567282','ericaxelsson@gmail.de')
GO

-----Inserting data into the LogIns table------
-----Inserting data into the LogIns table------

INSERT INTO LogIns(CustomerID,LoginPassword)
VALUES
(6006,'qwer#56789'),
(6007,'@bsdiduhnr'),
(6008,'%tsdtehbef'),
(6009,'456#ht7ed5'),
(6010,'ed45yhcv12'),
(6011,'ölkjhgfds5'),
(6012,'åpoiuytr5e'),
(6013,'ägy487#@hg'),
(6014,'ljugtrdewa'),
(6015,'njuytfresd'),
(6016,'lkiuyhrtef'),
(6017,'hyufrescvn')
GO


-----Inserting data into the CustomerAddress table------
-----Inserting data into the CustomerAddress table------

INSERT INTO CustomerAddress(CustomerID,StreetName,City,ZipCode)
VALUES
(6010,'Drottninggatan','Stockholm','456 98'),
(6016,'Västerlånggatan','Stockholm','234 89'),
(6006,'Stora Nygatan','Malmö','987 54'),
(6011,'Albin Holms Backe','Malmö','413 46'),
(6007,'Alivallsgatan','Södertälje','151 60'),
(6008,'Lorents Gata','Kalmar','405 08'),
(6017,'Aftonggatan','Västerås','418 75'),
(6012,'Almquistgatan','Uppsala','418 75'),
(6013,'Balingstaby','Karlskoga','755 91'),
(6009,'Champinjonvägen','Gävle','756 54'),
(6015,'Ellegatan','Halmstad','753 16'),
(6014,'Thunmansgatan','Göteborg','754 47'),
(6013,'Villingegatan','Falun','527 57'),
(6016,'Radargatan','Helsingborg','964 66')
GO


-----Inserting data into the AccountType table------
-----Inserting data into the AccountType table------

INSERT INTO AccountType(AccountTypeName)
VALUES
('Savings Account'),
('Checking Account')
GO


-----Inserting data into the Account table------
-----Inserting data into the Account table------

INSERT INTO Account(AccountTypeID,AccountNumber,Balance,Available,DateCreated)
VALUES
(21,'1234567890',1500,1500,'2019-10-07'),
(20,'9876543210',234567,167258,'2019-10-06'),
(20,'4567890123',320000,320000,'2019-10-05'),
(21,'7890123456',9005367,9004266,'2019-10-04'),
(20,'5678901234',4100,4100,'2019-10-03'),
(21,'2345678901',20000,13000,'2019-10-02'),
(20,'1111111111',180567,180000,'2019-10-01'),
(21,'2222222222',22050,22050,'2019-09-30'),
(21,'3333333333',270225,270125,'2019-09-29'),
(20,'4444444444',98075,97075,'2019-09-28'),
(21,'5555555555',35000,35000,'2019-09-27'),
(21,'6666666666',8505000,850500,'2019-09-26')
GO

-----Inserting data into the CardSecurity table------
-----Inserting data into the CardSecurity table------

INSERT INTO CardSecurity(CardNumber,CVC)
VALUES
('1234 5678 9012 3456',123),
('9876 5432 1098 7654',456),
('2345 6789 0123 4567',789),
('8765 4321 3456 7890',234),
('5432 1098 7654 3210',567),
('6789 0123 4567 8901',890),
('4321 3456 7890 1234',345),
('1098 7654 3210 9876',678),
('7654 3210 9876 5432',901),
('2109 8765 4321 0987',123),
('5432 1098 7654 3210',456),
('8765 4321 0987 6543',789),
('9876 5432 1098 7654',234)
GO


-----Inserting data into the Cards table------
-----Inserting data into the Cards table------

INSERT INTO Cards(CardSecurityID,CardType,CardTypeDescription,IssuedDate,ExpiryMonth,ExpiryYear)
VALUES
(30,'Credit Card','VISA','2020-10-07',10,2024),
(31,'Credit Card','VISA','2020-10-07',10,2025),
(32,'Debit Card','VISA','2020-10-07',10,2025),
(33,'Debit Card','MASTERCARD','2020-10-07',10,2025),
(34,'Debit Card','MASTERCARD','2020-10-07',10,2024),
(35,'Credit Card','VISA','2020-10-07',10,2024),
(36,'Debit Card','MASTERCARD','2020-10-07',10,2025),
(37,'Credit Card','VISA','2020-10-07',10,2024),
(38,'Debit Card','MASTERCARD','2020-10-07',10,2025),
(39,'Credit Card','VISA','2020-10-07',10,2025),
(40,'Debit Card','MASTERCARD','2020-10-07',10,2025),
(41,'Credit Card','VISA','2020-10-07',10,2025),
(42,'Debit Card','MASTERCARD','2020-10-07',10,2025)
GO


-----Inserting data into the Dispositions table------
-----Inserting data into the Dispositions table------

INSERT INTO Dispositions(CustomerID,AccountID,CardID)
VALUES
(6006,1200,412),
(6007,1100,412),
(6008,1000,410),
(6009,900,410),
(6010,800,408),
(6011,700,408),
(6012,600,406),
(6013,500,403),
(6014,400,404),
(6015,300,403),
(6016,200,402),
(6017,100,400),
(6011,600,400),
(6006,700,411),
(6012,800,409),
(6007,900,407),
(6017,1000,407),
(6010,1100,401),
(6016,1200,405),
(6009,100,405),
(6015,200,409),
(6007,300,401),
(6014,400,402),
(6008,500,403)
GO


-----Inserting data into the LoanType table------
-----Inserting data into the LoanType table------

INSERT INTO LoanType(LoanTypeName)
VALUES
('Personal Loan'), ----changed Private Loan to Personal Loan because Private is a keyword----
('Mortgage Loan'),
('Student Loan'),
('Business Loan')
GO


-----Inserting data into the Loan table------
-----Inserting data into the Loan table------

INSERT INTO Loan(AccountID,LoanTypeID,LoanNumber,LoanAmount,LoanDate,AmountPaid,Debt,FinalPaymentDate)
VALUES
(200,51,'543212',50000,'2023-10-01',5000,45000,'2028-10-01'),
(300,50,'678906',30000,'2022-01-19',10000,20000,'2024-01-19'),
(1100,53,'987656',50000,'2023-11-23',1000,49000,'2028-11-23'),
(900,50,'246803',70000,'2020-02-28',30000,40000,'2030-02-28'),
(500,51,'135795',80000,'2021-09-30',12000,68000,'2031-09-30'),
(900,52,'112238',10000,'2020-07-11',500,9500,'2024-07-11'),
(1000,53,'998877',50000,'2021-04-13',10000,40000,'2026-04-13'),
(1200,50,'445566',100000,'2022-10-15',50000,50000,'2033-10-15'),
(100,51,'112233',200000,'2023-11-19',50000,150000,'2036-11-19'),
(600,53,'778899',11000,'2022-12-21',1000,10000,'2024-12-21'),
(400,52,'990011',9000,'2020-09-16',9000,0,'2022-09-16')
GO


-----Inserting data into the TransactionType table------
-----Inserting data into the TransactionType table------

INSERT INTO TransactionType(TransactionTypeName)
VALUES
('Deposit'),
('Withdrawal')
GO


-----Inserting data into the Transactions table------
-----Inserting data into the Transactions table------

INSERT INTO Transactions(TransactionTypeID,AccountID,TransactionDate,TransactionAmount)
VALUES
(71,100,'2023-01-13',5000),
(71,200,'2023-02-14',1000),
(71,300,'2023-03-15',5000),
(71,400,'2023-04-16',10000),
(71,500,'2023-05-23',1900),
(71,600,'2023-06-17',400),
(71,700,'2023-07-18',200),
(71,800,'2023-08-19',2000),
(71,900,'2023-09-23',400),
(71,1000,'2022-10-23',500),
(71,1100,'2022-11-23',700),
(71,1200,'2022-12-23',600),
(70,100,'2023-01-23',15000),
(70,200,'2023-02-23',3000),
(70,300,'2023-03-01',60000),
(70,400,'2023-04-02',70000),
(70,500,'2023-05-20',22000),
(70,600,'2023-06-22',1100),
(70,700,'2022-07-07',4500),
(70,800,'2022-08-26',6000),
(70,900,'2022-09-30',5000),
(70,1000,'2022-10-28',4000),
(70,1100,'2022-11-11',3000),
(70,1200,'2022-12-29',10000)
GO

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
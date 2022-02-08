
-- CREATE DATABASE
DROP DATABASE IF EXISTS bank;
CREATE DATABASE IF NOT EXISTS bank;

-- CREATE CUSTOMER TABLES
-- CREATE STREET_ADDRESS TABLE FIRST
CREATE TABLE town (
	TownID INT NOT NULL AUTO_INCREMENT,
	TownName VARCHAR(100) NOT NULL,
	PRIMARY KEY (TownID)
);
-- INSERT STREET_ADDRESS VALUES
INSERT INTO town (TownName) VALUES
("Charlene rapids"),
("Suzanne port"),
("Goddard crest"),
("Shaw roads"),
("Kate glens"),
("Declan meadows"),
("Bruce wall"),
("Josh valley"),
("Martyn passage"),
("Turner ford");

-- CREATE ADDRESS TABLE SECOND
CREATE TABLE address (
	AddressID INT NOT NULL AUTO_INCREMENT,
    HouseNo INT NOT NULL,
	StreetName VARCHAR(100) NOT NULL,
    TownID INT NOT NULL,
	Postcode VARCHAR(7) NOT NULL,
	PRIMARY KEY (AddressID),
	FOREIGN KEY (TownID) REFERENCES town(TownID)
);
-- INSERT ADDRESS VALUES
INSERT INTO address (TownID, HouseNo, StreetName, Postcode) VALUES
(1, 10, "Lake Gary", "S0J 1PT"),
(2, 2, "Port Suzannefurt", "HU84 1GL"),
(3, 1, "North Hilaryberg", "S1F 3AE"),
(4, 5, "West Paige", "PR6 0UR"),
(5, 34, "New Lisa", "PE2Y 0HL"),
(6, 7, "New Ianberg", "CW4 2FG"),
(7, 11, "New Kathrynport", "W22 2JY"),
(8, 43, "Cliffordfurt", "E3 2JP"),
(9, 26, "South Debra", "HS7 8GW"),
(10, 26, "West Helenmouth", "IV4 3LN");

-- CREATE CUSTOMER TABLE THIRD
CREATE TABLE customer (
	CustomerID INT NOT NULL AUTO_INCREMENT,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	DateOfBirth DATE NOT NULL,
	AddressID INT NOT NULL,
	TelephoneNo VARCHAR(100) NOT NULL CHECK (TelephoneNo >= 11),
	PRIMARY KEY (CustomerID),
	FOREIGN KEY (AddressID) REFERENCES address(AddressID)
);
-- INSERT CUSTOMER VALUES
INSERT INTO customer (FirstName, LastName, DateOfBirth, AddressID, TelephoneNo) VALUES
("Damien", "Morgan", "1999-10-08", 1,"07700900241"),
("Ronald", "Baldwin", "1998-11-17", 2,"07700900767"),
("James", "Kaur", "1998-07-27", 3,"07700900927"),
("Sarah", "Wood", "1998-12-11", 4,"07700900147"),
("Gerard", "Sutton", "2000-07-01", 5,"07700900957"),
("Barry", "Banks", "1996-02-11", 6,"07700900962"),
("Alice", "Jones", "2002-12-01", 7,"07700900327"),
("Marcus", "Wright", "2001-10-23", 8,"07700900166"),
("Beth", "O'Donnell", "1997-04-17", 9,"07700900416"),
("Abbie", "Miles", "1996-04-26", 10,"07700900152");


-- CREATE ACCOUNT TABLES

CREATE TABLE branch ( 
	BranchName VARCHAR(50) NOT NULL,
	Sortcode VARCHAR(10) NOT NULL,
	PRIMARY KEY (Sortcode)
);
INSERT INTO branch (BranchName, Sortcode) VALUES
("Lincoln High Street", "04-00-06");

CREATE TABLE account_type (
	AccountTypeID INT NOT NULL AUTO_INCREMENT,
	AccountType VARCHAR(50) NOT NULL,
	PRIMARY KEY (AccountTypeID)
);
INSERT INTO account_type (AccountType) VALUES
("Current"),
("Savings"),
("ISA");

CREATE TABLE account (
	CustomerID INT NOT NULL,
	AccountNo INT NOT NULL AUTO_INCREMENT,
	Sortcode VARCHAR(50) NOT NULL,
	AccountTypeID INT NOT NULL,
	OpeningBalance INT NOT NULL CHECK (OpeningBalance > 50),
	PRIMARY KEY (AccountNo),
	FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID),
	FOREIGN KEY (SortCode) REFERENCES branch(SortCode),
	FOREIGN KEY (AccountTypeID) REFERENCES account_type(AccountTypeID)
);
ALTER TABLE account AUTO_INCREMENT=1001;
INSERT INTO account (CustomerID, Sortcode, AccountTypeID, OpeningBalance) VALUES
(1, "04-00-06", 1, 100.00),
(2, "04-00-06", 2, 120.00),
(3, "04-00-06", 2, 200.00),
(4, "04-00-06", 1, 70.00),
(5, "04-00-06", 3, 400.00),
(6, "04-00-06", 1, 1000.00),
(7, "04-00-06", 1, 160.00),
(8, "04-00-06", 1, 55.00),
(9, "04-00-06", 3, 600.00),
(10, "04-00-06",1, 150.00);


-- CREATE TRANSACTION TABLES

CREATE TABLE transaction_type (
	TransactionTypeID INT NOT NULL AUTO_INCREMENT,
	TransactionType VARCHAR(50) NOT NULL,
	PRIMARY KEY (TransactionTypeID)
);
INSERT INTO transaction_type(TransactionType) VALUES
("Initial Deposit"),
("Deposit"),			
("Withdraw"),			
("Transfer"),			
("Card Payment"),		
("Direct Debit"),		
("Loan Repayment"),		
("E-Payment");	

CREATE TABLE transaction (
	TransactionID INT NOT NULL AUTO_INCREMENT,
	AccountNo INT NOT NULL,
	Incoming INT DEFAULT 0,
	Outgoing INT DEFAULT 0,
	TransactionTypeID INT NOT NULL,
	Timestamp DATETIME,
	PRIMARY KEY (TransactionID),
	FOREIGN KEY (AccountNo) REFERENCES account(AccountNo),
	FOREIGN KEY (TransactionTypeID) REFERENCES transaction_type(TransactionTypeID)
);		

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1002, 1, 1000.00, 0.00, '2022-01-20 15:13:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1003, 1, 55.00, 0.00, '2022-02-01 11:55:00');


INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1006, 1, 1000.00, 0.00, '2022-01-01 10:14:00'),
(1006, 7, 0.00, 300.00, '2022-01-04 14:02:00'),
(1006, 2, 2010.00, 20.00, '2022-01-10 07:32:00'),
(1006, 5, 0.00, 200.00, '2022-01-16 11:21:00'),
(1006, 7, 0.00, 300.00, '2022-01-20 16:04:00'),
(1006, 2, 1470.00, 20.00, '2022-01-21 06:40:00'),
(1006, 3, 0.00, 50.00, '2022-01-26 11:21:00'),
(1006, 7, 0.00, 300.00, '2022-01-29 10:45:00'),
(1006, 6, 1410, 00.00, '2022-01-30 14:52:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1008, 1, 2140.00, 0.00, '2022-01-02 10:30:00'),
(1008, 2, 1040.00, 0.00, '2022-01-20 13:01:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1004, 1, 1400.00, 0.00, '2022-02-01 07:43:00'),
(1004, 7, 0.00, 100.00, '2022-02-02 10:21:00'),
(1004, 2, 400.00, 0.00, '2022-02-03 14:30:00'),
(1004, 5, 0.00, 50.00, '2022-02-06 07:43:00'),
(1004, 6, 700.00, 0.00, '2022-02-09 07:43:00'),
(1004, 3, 0.00, 200.00, '2022-02-12 07:43:00'),
(1004, 2, 1040.00, 0.00, '2022-02-14 07:43:00'),
(1004, 8, 0.00, 54.00, '2022-02-15 07:43:00'),
(1004, 2, 510.00, 0.00, '2022-02-18 07:43:00'),
(1004, 3, 0.00, 110.00, '2022-02-21 07:43:00'),
(1004, 3,  0.00, 50.00, '2022-02-24 07:43:00'),
(1004, 7, 0.00, 100.00, '2022-02-26 07:43:00'),
(1004, 6, 2402.00, 0.00, '2022-02-27 07:43:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1009, 1, 100.00, 0.00, '2022-01-10 12:03:00'),
(1009, 2, 500.00, 0.00,'2022-01-30 10:41:00'),
(1009, 4, 0.00, 100.00, '2022-01-31 20:01:00');

INSERT INTO transaction (AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1005, 1, 200.00, 0.00, '2021-10-01 09:10:00'),
(1005, 3, 0.00, 10.00, '2021-10-02 07:20:00'),
(1005, 3, 0.00, 20.00, '2021-10-03 09:40:00'),
(1005, 2, 100.00, 0.00, '2021-10-04 10:20:00'),
(1005, 6, 0.00, 5.00, '2021-10-05 07:02:00'),
(1005, 3, 0.00, 10.00, '2021-10-05 14:10:00'),
(1005, 2, 200.00, 0.00, '2021-10-06 10:05:00'),
(1005, 2, 400.00, 0.00, '2021-10-07 07:20:00'),
(1005, 5, 0.00, 50.00, '2021-10-08 09:40:00'),
(1005, 6, 0.00, 20.00, '2021-10-09 17:04:00'),
(1005, 3, 0.00, 10.00, '2021-10-10 07:40:00'),
(1005, 6, 150.00, 0.00, '2021-10-11 16:40:00'),
(1005, 8, 0.00, 20.00, '2021-10-12 20:40:00'),
(1005, 5, 0.00, 20.00, '2021-10-13 20:40:00'),
(1005, 7, 0.00, 100.00, '2021-10-14 07:14:00'),
(1005, 3, 0.00, 10.00, '2021-10-15 14:02:00'),
(1005, 2, 500.00, 00.00, '2021-10-16 10:06:00'),
(1005, 3, 0.00, 40.00, '2021-10-17 07:50:00'),
(1005, 6, 0.00, 14.00, '2021-10-17 14:07:00'),
(1005, 2, 500.00, 0.00, '2021-10-18 10:55:00'),
(1005, 8, 0.00, 20.00, '2021-10-19 19:55:00'),
(1005, 3, 0.00, 10.00, '2021-10-20 06:10:00'),
(1005, 2, 140.00, 0.00, '2021-10-21 12:10:00'),
(1005, 2, 200.00, 0.00, '2021-10-22 16:45:00'),
(1005, 5, 0.00, 20.00, '2021-10-23 14:20:00'),
(1005, 6, 0.00, 5.00, '2021-10-24 20:14:00'),
(1005, 2, 400.00, 0.00, '2021-10-25 10:20:00'),
(1005, 7, 0.00, 100.00, '2021-10-26 10:40:00'),
(1005, 5, 0.00, 40.00, '2021-10-27 16:07:00'),
(1005, 5, 0.00, 10.00, '2021-10-29 21:40:00'),
(1005, 3, 0.00, 20.00, '2021-10-29 21:40:00'),
(1005, 3, 0.00, 10.00, '2021-10-30 06:02:00');


INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1001, 1, 100.00, 0.00, '2021-11-01 10:20:00'),
(1001, 3, 0.00, 10.00, '2021-11-02 10:00:00'),
(1001, 3, 0.00, 20.00, '2021-11-03 14:25:00'),
(1001, 4, 100.00, 0.00, '2021-11-04 09:15:00'),
(1001, 3, 0.00, 20.00, '2021-11-05, 10:00:00'),
(1001, 7, 0.00, 140.00, '2021-11-06 13:04:00'),
(1001, 3, 0.00, 20.00, '2021-11-07 06:34:00'),
(1001, 4, 200.00, 0.00, '2021-11-08 17:02:00'),
(1001, 6, 0.00, 5.00, '2021-11-09 09:00:00'),
(1001, 5, 0.00, 20.00, '2021-11-10, 06:29:00'), 
(1001, 8, 0.00, 15.00, '2021-11-12 10:06:00'),
(1001, 3, 0.00, 10.00, '2021-11-13 10:00:00'),
(1001, 5, 0.00, 5.00, '2021-11-14 19:42:00'),
(1001, 2, 50.00, 0.00, '2021-11-15 13:36:00'),
(1001, 6, 0.00, 53.00, '2021-11-16 11:00:00'),
(1001, 8, 0.00, 4.00, '2021-11-17 15:02:50'),
(1001, 4, 100.00, 0.00, '2021-11-18 10:45:00'),
(1001, 5, 0.00, 20.00, '2021-11-19 14:05:00'),
(1001, 3, 0.00, 10.00, '2021-11-20 07:01:00'),
(1001, 3, 0.00, 10.00, '2021-11-21 07:10:00'),
(1001, 8, 0.00, 6.00, '2021-11-22 13:20:00'),
(1001, 2, 100.00, 0.00, '2021-11-23 09:55:00'),
(1001, 6, 0.00, 14.00, '2021-11-24 06:02:50'),
(1001, 3, 0.00, 10.00, '2021-11-25 16:20:00'),
(1001, 3, 0.00, 20.00, '2021-11-26 17:06:00'),
(1001, 5, 0.00, 5.00, '2021-11-27 20:56:00'),
(1001, 5, 0.00, 20.00, '2021-11-28 09:01:00'),
(1001, 2, 1240.00, 0.00, '2021-11-29 07:30:00'),
(1001, 7, 140.00, 0.00, '2021-11-30 14:22:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1010, 1, 150.0, 0.00, '2022-01-01 10:02:00'),
(1010, 2, 500.0, 0.00, '2022-01-02 14:40:00'),
(1010, 2, 400.0, 0.00, '2022-01-03 16:10:00'),
(1010, 8, 0.0, 20.00, '2022-01-04 10:02:00'),
(1010, 8, 0.0, 4.00, '2022-01-05 14:50:00'),
(1010, 3, 0.0, 40.00, '2022-01-06 09:37:00'),
(1010, 6, 0.0, 16.00, '2022-01-07 11:20:00'),
(1010, 2, 400.0, 0.00, '2022-01-08 07:05:00'),
(1010, 2, 200.0, 0.00, '2022-01-09 11:40:00'),
(1010, 6, 100.0, 0.00, '2022-01-10 14:01:00'),
(1010, 5, 0.00, 50.00, '2022-01-11 07:20:00'),
(1010, 5, 0.00, 20.00, '2022-01-12 10:30:00'),
(1010, 7, 200.00, 0.00, '2022-01-13 10:45:00'),
(1010, 8, 0.00, 20.00, '2022-01-14 13:05:00'),
(1010, 3, 0.00, 50.00, '2022-01-15 07:12:00'),
(1010, 3, 0.00, 30.00, '2022-01-16 09:02:00'),
(1010, 2, 400.00, 0.00, '2022-01-17 14:57:00'),
(1010, 4, 0.00, 20.00, '2022-01-18 20:01:00'),
(1010, 8, 0.00, 10.00, '2022-01-19 16:41:00'),
(1010, 6, 100.00, 0.00, '2022-01-20 15:30:00'),
(1010, 6, 300.00, 0.00, '2022-01-21 07:22:00'),
(1010, 3, 0.00, 20.00, '2022-01-22 10:24:00'),
(1010, 3, 0.00, 100.00, '2022-01-23 17:40:00'),
(1010, 3, 0.00, 40.00, '2022-01-24 07:54:00'),
(1010, 2, 500.00, 20.00, '2022-01-25 16:32:00'),
(1010, 8, 0.00, 10.00, '2022-01-26 10:41:00'),
(1010, 7, 0.00, 200.00, '2022-01-27 10:30:00'),
(1010, 6, 1430.00, 0.00, '2022-01-28 17:52:00'),
(1010, 5, 0.00, 20.00, '2022-01-29 17:52:00');

INSERT INTO transaction(AccountNo, TransactionTypeID, Incoming, Outgoing, Timestamp) VALUES
(1007, 1, 200.00, 0.00, '2022-01-01 10:02:00'),
(1007, 2, 1040.00, 0.00, '2022-01-05 17:34:00'),
(1007, 3, 0.00, 100.00, '2022-01-14 13:45:00'),
(1007, 6, 340.00, 0.00, '2022-01-20 16:30:00'),
(1007, 5, 0.00, 130.00, '2022-01-26 14:50:00'),
(1007, 5, 0.00, 20.00, '2022-01-30 07:10:00'),
(1007, 8, 0.00, 15.00, '2022-01-31 20:05:00');


-- CREATE LOAN TABLES
CREATE TABLE loan_payment (
	PaymentID INT NOT NULL AUTO_INCREMENT,
	PaymentRate INT,
	MonthlyPayments INT,
	FirstPayment DATE,
	MonthlyDueDate INT,
	PRIMARY KEY(PaymentID)
);
INSERT INTO loan_payment (PaymentRate, MonthlyPayments, FirstPayment, MonthlyDueDate) VALUES
(140.00, 6, '2020-11-10', 10),
(200.00, 4, '2021-10-14', 14),
(50.00,  24, '2022-01-06', 6),
(500.00, 4, '2022-01-21', 21),
(110.00, 10, '2021-11-03', 3);

CREATE TABLE loan (
	CustomerID INT NOT NULL,
	AccountNo INT NOT NULL,
    PaymentID INT NOT NULL,
	PRIMARY KEY (CustomerID, AccountNo),
	FOREIGN KEY (AccountNo) REFERENCES account(AccountNo),
	FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID),
	FOREIGN KEY (PaymentID) REFERENCES loan_payment(PaymentID)
);
INSERT INTO loan (CustomerID, AccountNo, PaymentID) VALUES
(1, 1001, 1),
(10,1010, 2),
(5, 1005, 3),
(6, 1006, 4),
(4, 1004, 5);

-- 4.1
SELECT customer.CustomerID, customer.FirstName, customer.LastName, customer.AddressID, customer.TelephoneNo, account.AccountNo, loan_payment.MonthlyDueDate
FROM loan
INNER JOIN customer ON loan.CustomerID = customer.CustomerID
INNER JOIN account ON loan.AccountNo = account.AccountNo
INNER JOIN loan_payment ON loan.PaymentID = loan_payment.PaymentID
WHERE loan_payment.MonthlyDueDate BETWEEN 1 AND 7;

-- 4.2
SELECT customer.CustomerID, customer.FirstName,customer.LastName, account.AccountNo,
TransactionID, transaction_type.TransactionType, Incoming, Outgoing, Timestamp,
DATEDIFF(transaction.Timestamp, '2022-01-01') AS DateDiff
FROM transaction
INNER JOIN account ON transaction.AccountNo = account.AccountNo
INNER JOIN customer ON account.CustomerID = customer.CustomerID
INNER JOIN transaction_type ON transaction.TransactionTypeID = transaction_type.TransactionTypeID
HAVING DateDiff BETWEEN 0 AND 4;

-- 4.3
SELECT C.CustomerID, C.FirstName, C.LastName, C.DateOfBirth, C.AddressID, C.TelephoneNo
FROM customer C, account A
WHERE C.CustomerID = A.CustomerID AND A.AccountNo IN (
        SELECT AccountNo
        FROM transaction T
        GROUP BY AccountNo
        HAVING SUM(T.Incoming - T.Outgoing) > 5000
    	);

-- 4.4
SELECT SUM(T.Incoming - T.Outgoing) AS TotalOutstandings FROM transaction T;

-- 4.5
DROP PROCEDURE IF EXISTS RetrieveTransactionsInPast;

DELIMITER //
CREATE PROCEDURE RetrieveTransactionsInPast (IN date DATE, IN days INT)
BEGIN
	SELECT customer.CustomerID, customer.FirstName, customer.LastName, account.AccountNo,
    transaction.TransactionID, transaction_type.TransactionType, transaction.Incoming, transaction.Outgoing, transaction.Timestamp, 
    DATEDIFF(transaction.Timestamp, date) AS DateDiff
    FROM transaction
    INNER JOIN account ON transaction.AccountNo = account.AccountNo
    INNER JOIN customer ON account.CustomerID = customer.CustomerID
    INNER JOIN transaction_type ON transaction.TransactionTypeID = transaction_type.TransactionTypeID
    HAVING DateDiff BETWEEN 0 AND days;
END//
DELIMITER ;

CALL RetrieveTransactionsInPast('2022-01-01', 5);

-- 4.6
DROP PROCEDURE IF EXISTS CurrentBalanceGreaterThan;
DELIMITER //
CREATE PROCEDURE CurrentBalanceGreaterThan(IN value INT)
BEGIN
SELECT C.CustomerID, C.FirstName, C.LastName, C.DateOfBirth, C.AddressID, C.TelephoneNo
FROM customer C, account A
WHERE C.CustomerID = A.CustomerID AND A.AccountNo IN (
        SELECT AccountNo
        FROM transaction T
        GROUP BY AccountNo
        HAVING SUM(T.Incoming - T.Outgoing) > value
    	);
END//
DELIMITER ;

CALL CurrentBalanceGreaterThan(5000);
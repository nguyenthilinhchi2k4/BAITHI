CREATE DATABASE newAzbank
GO
USE newAZBank
GO
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    Name NVARCHAR(50),
    City NVARCHAR(50),
    Country NVARCHAR(15),
    Phone NVARCHAR(50),
    Email NVARCHAR(50)
);
INSERT INTO Customer (CustomerId, Name, City, Country, Phone, Email)
VALUES
    (1, N'John Doe', N'Hanoi', N'Vietnam', N'123456789', 'john.doe@example.com'),
    (2, N'Jane Smith', N'Ho Chi Minh City', N'Vietnam', '987654321', 'jane.smith@example.com'),
    (3, N'David Johnson', N'Hanoi', N'Vietnam', N'555555555', 'david.johnson@example.com');

SELECT *
FROM Customer
WHERE City = 'Hanoi';

SELECT *
FROM Customer
WHERE City = 'Ho Chi Minh City';


CREATE TABLE CustomerAccount (
    AccountNumber CHAR(9) PRIMARY KEY,
    CustomerId INT,
    Balance MONEY,
    MinAccount MONEY,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);
INSERT INTO CustomerAccount (AccountNumber, CustomerId, Balance, MinAccount)
VALUES
    ('NO01', 1, 1090.0, 100.0),
    ('NO02', 2, 2080.0, 200.0),
    ('NO03', 3, 3900.0, 300.0);
CREATE TABLE CustomerTransaction (
    TransactionId INT PRIMARY KEY,
    AccountNumber CHAR(9),
    TransactionDate SMALLDATETIME,
    Amount MONEY,
    DepositorWithdraw NVARCHAR(10),
    FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber)
);
INSERT INTO CustomerAccount (AccountNumber, CustomerId)
VALUES
    ('AC003', 1),
    ('AC004', 2),
    ('AC005', 3);

	INSERT INTO CustomerTransaction (TransactionId, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES
    (1, 'AC003', '2023-01-01', 500.0, N'Deposit'), -- Corrected AccountNumber value
    (2, 'AC004', '2023-01-02', 1000.0, N'Withdrawal'), -- Corrected AccountNumber value
    (3, 'AC005', '2023-01-03', 1500.0, N'Deposit'); -- Corrected AccountNumber value
	SELECT*FROM CustomerTransaction

ALTER TABLE CustomerTransaction
ADD CONSTRAINT CHK_CustomerTransaction_Amount
CHECK (Amount > 0 AND Amount <= 1000000);
SELECT c.Name, ca.Phone, ca.Email, ca.AccountNumber, ca.Balance
FROM Customer c
JOIN CustomerAccount ca ON c.CustomerId = ca.CustomerId;

CREATE VIEW vCustomerTransactions
AS
SELECT c.Name, ct.AccountNumber, ct.TransactionDate, ct.Amount, ct.DepositorWithdraw
FROM Customer c
JOIN CustomerAccount ca ON c.CustomerId = ca.CustomerId
JOIN CustomerTransaction ct ON ca.AccountNumber = ct.AccountNumber;

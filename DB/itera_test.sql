CREATE DATABASE itera_claims
GO

USE itera_claims
GO

--
-- Definition for table ClaimType : 
--

CREATE TABLE dbo.ClaimType (
  ID int IDENTITY(1, 1) NOT NULL,
  Name varchar(50),
  CONSTRAINT PK_ClaimType_ID PRIMARY KEY CLUSTERED (ID)
)
GO

--
-- Definition for table Claim : 
--

CREATE TABLE dbo.Claim (
  ID int IDENTITY(1, 1) NOT NULL,
  Year int NOT NULL,
  Name varchar(50),
  TypeID int NOT NULL,
  GrossClaim numeric(15, 2) NOT NULL,
  Deductible numeric(15, 2) NOT NULL,
  CONSTRAINT PK_Claim_ID PRIMARY KEY CLUSTERED (ID)
)
GO

--
-- Data for table dbo.ClaimType  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.ClaimType ON
GO

INSERT INTO dbo.ClaimType (ID, Name)
VALUES 
  (1, N'Collision')
GO

INSERT INTO dbo.ClaimType (ID, Name)
VALUES 
  (2, N'Grounding')
GO

INSERT INTO dbo.ClaimType (ID, Name)
VALUES 
  (3, N'Bad Weather')
GO

INSERT INTO dbo.ClaimType (ID, Name)
VALUES 
  (4, N'Fire')
GO

SET IDENTITY_INSERT dbo.ClaimType OFF
GO

--
-- Data for table dbo.Claim  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.Claim ON
GO

INSERT INTO dbo.Claim (ID, Year, Name, TypeID, GrossClaim, Deductible)
VALUES 
  (1, 2009, N'First Claim', 2, 100000, 20345.34)
GO

INSERT INTO dbo.Claim (ID, Year, Name, TypeID, GrossClaim, Deductible)
VALUES 
  (2, 2010, N'Second Claim', 3, 24567.66, 1200)
GO

INSERT INTO dbo.Claim (ID, Year, Name, TypeID, GrossClaim, Deductible)
VALUES 
  (3, 2015, N'Large money Claim', 4, 18200.88, 310.99)
GO

INSERT INTO dbo.Claim (ID, Year, Name, TypeID, GrossClaim, Deductible)
VALUES 
  (4, 2019, N'One more Claim', 2, 55200.10, 2166.40)
GO

INSERT INTO dbo.Claim (ID, Year, Name, TypeID, GrossClaim, Deductible)
VALUES 
  (5, 2017, N'Just another one', 1, 2000, 300)
GO

SET IDENTITY_INSERT dbo.Claim OFF
GO

--
-- Definition for foreign keys : 
--

ALTER TABLE dbo.Claim
ADD CONSTRAINT FK_Claim_ClaimType_ID FOREIGN KEY (TypeID) 
  REFERENCES dbo.ClaimType (ID) 
  ON UPDATE NO ACTION
  ON DELETE NO ACTION
GO


-- -------------------------------------------
-- Normalisation examples 
-- (c) 2018-2019, Björn Þór Jónsson
-- -------------------------------------------

-- 6: Person relation
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    ID INT PRIMARY KEY,
    Name CHARACTER VARYING NOT NULL,
    ZIP INT NOT NULL,
    City CHARACTER VARYING NOT NULL
);

INSERT INTO Person VALUES (1, 'Björn', 2100, 'København Ø');
INSERT INTO Person VALUES (2, 'Johan', 2300, 'København S');
INSERT INTO Person VALUES (3, 'Peter', 2100, 'København Ø');

SELECT *
FROM Person;

-- 8: Decompose the relation
CREATE TABLE ZIP (
    ZIP INT PRIMARY KEY,
    City CHARACTER VARYING NOT NULL
);

INSERT INTO ZIP
SELECT DISTINCT ZIP, City
FROM Person;

ALTER TABLE Person ADD CONSTRAINT FOREIGN KEY (ZIP) REFERENCES ZIP(ZIP);
ALTER TABLE Person DROP COLUMN City;

-- 7: Re-join the relation
SELECT P.ID, P.Name, P.ZIP, Z.City
FROM Person P JOIN ZIP Z ON P.ZIP = Z.ZIP;

SELECT *
FROM Person;

SELECT *
FROM ZIP;

-- 13: SQL method of detecting FDs
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    ID INT PRIMARY KEY,
    Name CHARACTER VARYING NOT NULL,
    ZIP INT NOT NULL,
    City CHARACTER VARYING NOT NULL
);

INSERT INTO Person VALUES (1, 'Björn', 2100, 'København Ø');
INSERT INTO Person VALUES (2, 'Johan', 2300, 'København S');
INSERT INTO Person VALUES (3, 'Peter', 2100, 'København Ø');
--------------------------------------------------

SELECT 'Person: ZIP --> City' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.ZIP
	FROM Person P
	GROUP BY P.ZIP
	HAVING COUNT(DISTINCT P.City) > 1
) X;

SELECT 'Person: ZIP --> Name' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.ZIP
	FROM Person P
	GROUP BY P.ZIP
	HAVING COUNT(DISTINCT P.Name) > 1
) X;

SELECT 'Person: ID --> Name' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.ID
	FROM Person P
	GROUP BY P.ID
	HAVING COUNT(DISTINCT P.Name) > 1
) X;

SELECT 'Person: City --> ZIP' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.City
	FROM Person P
	GROUP BY P.City
	HAVING COUNT(DISTINCT P.ZIP) > 1
) X;

SELECT 'Person: Name, City --> ZIP' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.Name, P.City
	FROM Person P
	GROUP BY P.Name, P.City
	HAVING COUNT(DISTINCT P.ZIP) > 1
) X;

--------------------------------------------------

-- 17: Relation with 2 keys in BCNF
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    ID INT PRIMARY KEY,
    CPR CHAR(10) NOT NULL UNIQUE,
    Name CHARACTER VARYING NOT NULL,
    ZIP INT NOT NULL REFERENCES ZIP(ZIP)
);

INSERT INTO Person VALUES (1, 'Björn', '0123456789', 2100);
INSERT INTO Person VALUES (2, 'Johan', '9876543210', 2300);
INSERT INTO Person VALUES (3, 'Peter', '1122334455', 2100);

SELECT *
FROM Person;

-- 19: PaysFor relation
CREATE TABLE PaysFor (
	AID INTEGER,
	TID INTEGER,
	CID INTEGER, --REFERENCES Clubs,
	amount INTEGER,
	--FOREIGN KEY (AID, TID) REFERENCES CompetesIn (AID, TID),
	PRIMARY KEY (AID, TID, CID)
);

INSERT INTO PaysFor VALUES (1, 1, 1, 1000);
INSERT INTO PaysFor VALUES (1, 2, 1, 5000);
INSERT INTO PaysFor VALUES (1, 3, 1, 600);
INSERT INTO PaysFor VALUES (2, 1, 1, 1000);
INSERT INTO PaysFor VALUES (3, 4, 2, 1000);

select * 
from PaysFor;

SELECT 'PaysFor: AID --> CID' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
	SELECT P.AID
	FROM PaysFor P
	GROUP BY P.AID
	HAVING COUNT(DISTINCT P.CID) > 1
) X;

-- 21: Corrected tables
CREATE TABLE PaysFor (
	AID INTEGER,
	TID INTEGER,
	amount INTEGER,
	--FOREIGN KEY (AID, TID) REFERENCES CompetesIn (AID, TID),
	PRIMARY KEY (AID, TID)
);

CREATE TABLE AthleteClub (
	AID INTEGER PRIMARY KEY, -- REFERENCES Athletes
	CID INTEGER, -- REFERENCES Clubs,
	amount INTEGER,
);

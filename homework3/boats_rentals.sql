
/* Boats */

DROP TABLE IF EXISTS Boats_n;
CREATE TABLE Boats_n (
	bl CHAR(2), 
	bno INT, 
	z INT REFERENCES Towns(z), 
	bn VARCHAR(50), 
	ssn CHAR(10),
	PRIMARY KEY (bl, bno)
);

DROP TABLE IF EXISTS Towns_r;
CREATE TABLE Towns;
	z INT PRIMARY KEY, 
	t VARCHAR(50)
);

INSERT INTO Towns_b (z, t)
SELECT DISTINCT z, t
FROM Boats

INSERT INTO Boats_n (bl, bno, z, bn, ssn)
SELECT bl, bno, z, bn, ssn
FROM Boats

/* Rentals */

DROP TABLE IF EXISTS Rentals_n;
CREATE TABLE Rentals_n (
       pid INT REFERENCES Persons(pid),
       hid INT REFERENCES Houses(hid),
       s INT NOT NULL, 
       primary key (pid, hid)
);


DROP TABLE IF EXISTS Persons;
CREATE TABLE Persons (
       pid INT PRIMARY KEY,
       pn VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Houses;
CREATE TABLE Houses (
       hid INT PRIMARY KEY, 
       hs VARCHAR(50) NOT NULL,
       hz INT REFERENCES Towns(hz)
);

DROP TABLE IF EXISTS Towns_r;
CREATE TABLE Towns (
       hz INT PRIMARY KEY, 
       hc VARCHAR(50) NOT NULL
);

INSERT INTO Towns_r (hz, hc)
SELECT DISTINCT hz, hc
FROM Rentals

INSERT INTO Houses (hid, hs, hz)
SELECT DISTINCT hid, hs, hz
FROM Rentals

INSERT INTO Persons (pid, pn)
SELECT DISTINCT pid, pn
FROM Rentals

INSERT INTO Rentals_n (pid, hid, s)
SELECT DISTINCT pid, hid, s
FROM Rentals

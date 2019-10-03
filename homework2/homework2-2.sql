
DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    adress VARCHAR(100) NOT NULL,
    phone INT NOT NULL,
    DOB DATE NOT NULL,
    DOD DATE
);

DROP TABLE IF EXISTS Member;
CREATE TABLE Member (
    ID SERIAL PRIMARY KEY,
    startdate DATE NOT NULL,
    FOREIGN KEY (ID) REFERENCES Person (ID)
);

DROP TABLE IF EXISTS Enemy;
CREATE TABLE Enemy (
    ID INT PRIMARY KEY,
    FOREIGN KEY (ID) REFERENCES Person (ID)
);

DROP TABLE IF EXISTS Opponents;
CREATE TABLE Opponents (
    MemberID INT,
    EnemyID INT,
    startdate DATE NOT NULL,
    enddate DATE,
    FOREIGN KEY (MemberID) REFERENCES Member(ID),
    FOREIGN KEY (EnemyID) REFERENCES Enemy(ID),
    PRIMARY KEY (MemberID, EnemyID, startdate)
);


DROP TABLE IF EXISTS Linking;
CREATE TABLE Linking (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS Participates;
CREATE TABLE Participates (
    PersonID INT,
    LinkingID INT,
    PRIMARY KEY(PersonID, LinkingID),
    FOREIGN KEY (PersonID) REFERENCES Person(ID),
    FOREIGN KEY (LinkingID) REFERENCES Linking(ID)
);

DROP TABLE IF EXISTS Role;
CREATE TABLE Role (
    ID SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL UNIQUE,
    salary VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Fulfills;
CREATE TABLE Fulfills (
    MemberID INT,
    RoleID INT,
    startdate DATE NOT NULL,
    enddate DATE NOT NULL,
    PRIMARY KEY(MemberID, RoleID),
    FOREIGN KEY (MemberID) REFERENCES Member(ID),
    FOREIGN KEY (RoleID) REFERENCES Role(ID)
);

DROP TABLE IF EXISTS Party;
CREATE TABLE Party (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    UNIQUE (country, name),
    monitoredBy INT NOT NULL,
    FOREIGN KEY (monitoredBy) REFERENCES Member(ID)
);

DROP TABLE IF EXISTS Asset;
CREATE TABLE Asset (
    name VARCHAR(50) NOT NULL,
    use_desc VARCHAR(200) NOT NULL,
    detail_desc VARCHAR(200) NOT NULL,
    MemberID INT NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(ID),
    PRIMARY KEY (MemberID, name)
);

DROP TABLE IF EXISTS Sponsor;
CREATE TABLE Sponsor (
    ID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    adress VARCHAR(100) NOT NULL,
    industry VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Grants;
CREATE TABLE Grants (
    MemberID INT,
    SponsorID INT,
    date DATE NOT NULL,
    amount INT NOT NULL,
    payback VARCHAR(100) NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Member(ID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(ID),
    PRIMARY KEY (MemberID, SponsorID, date)
);

DROP TABLE IF EXISTS Reviews;
CREATE TABLE Reviews (
    MemberID INT,
    SponsorID INT,
    grant_date DATE,
    grade INT CHECK (grade > 0 AND grade <= 10),
    date DATE NOT NULL,
    FOREIGN KEY (MemberID, SponsorID, grant_date) REFERENCES Grants(MemberID, SponsorID, date),
    PRIMARY KEY (MemberID, SponsorID, grant_date)
);





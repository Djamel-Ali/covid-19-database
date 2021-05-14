CREATE TABLE Departement
(
    numDep CHAR(3) PRIMARY KEY,
    nomDep VARCHAR NOT NULL UNIQUE,
    numReg INTEGER REFERENCES Region(numReg)
);
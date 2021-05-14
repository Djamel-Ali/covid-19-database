CREATE TABLE Incidence
(
    numDep    CHAR(3) REFERENCES Departement (numDep),
    jour      DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    PRIMARY KEY (numDep, jour),
    incidHosp INTEGER NOT NULL CHECK (incidHosp >= 0),
    incidRea  INTEGER NOT NULL CHECK (incidRea >= 0),
    incidRad  INTEGER NOT NULL CHECK (incidRad >= 0),
    incidDc   INTEGER NOT NULL CHECK (incidDc >= 0),
    nbSvce    INTEGER NOT NULL CHECK (nbSvce >= 0)
);
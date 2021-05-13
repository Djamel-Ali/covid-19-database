CREATE TEMP TABLE TempIncidDep
(
    numDep    CHAR(3),
    jour      DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    PRIMARY KEY (numDep, jour),
    incidHosp INTEGER NOT NULL CHECK (incidHosp >= 0),
    incidRea  INTEGER NOT NULL CHECK (incidRea >= 0),
    incidDc   INTEGER NOT NULL CHECK (incidDc >= 0),
    incidRad  INTEGER NOT NULL CHECK (incidRad >= 0)
);

CREATE TEMP TABLE TempIncidReg
(
    jour     DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    nomReg   VARCHAR NOT NULL,
    numReg   INTEGER,
    PRIMARY KEY (jour, numReg),
    incidRea INTEGER NOT NULL CHECK (incidRea >= 0)
);


CREATE TEMP TABLE TempService
(
    numDep CHAR(3),
    jour   DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    PRIMARY KEY (numDep, jour),
    nbSvce INTEGER NOT NULL CHECK (nbSvce >= 0)
);

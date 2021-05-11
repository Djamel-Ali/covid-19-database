CREATE TABLE SexesDep
(
    numDep       CHAR(3) REFERENCES Departement(numDep),
    jour         DATE NOT NULL CHECK (jour <= CURRENT_DATE),
    idSexe       INTEGER REFERENCES Sexe (idSexe),
    PRIMARY KEY (numDep, jour, idSexe),
    hospSexe     INTEGER NOT NULL CHECK (hospSexe >= 0),
    reaSexe      INTEGER NOT NULL CHECK (reaSexe >= 0),
    radSexe      INTEGER NOT NULL CHECK (radSexe >= 0),
    dcSexe       INTEGER NOT NULL CHECK (dcSexe >= 0),
    ssrUsldSexe  INTEGER CHECK (ssrUsldSexe >= 0),
    hospConvSexe INTEGER CHECK (hospConvSexe >= 0),
    autreSexe    INTEGER CHECK (autreSexe >= 0)
);

DROP TABLE IF EXISTS TotalSexeDep;
CREATE TEMP TABLE TotalSexeDep
(
    numDep        CHAR(3),
    jour          DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    idSexe        INTEGER NOT NULL CHECK (idSexe = 0),
    PRIMARY KEY (numDep, jour, idSexe),
    countHosp     INTEGER NOT NULL CHECK (countHosp >= 0),
    countRea      INTEGER NOT NULL CHECK (countRea >= 0),
    countRad      INTEGER NOT NULL CHECK (countRad >= 0),
    countDc       INTEGER NOT NULL CHECK (countDc >= 0),
    countSsrUsld  INTEGER CHECK (countSsrUsld >= 0),
    countHospConv INTEGER CHECK (countHospConv >= 0),
    countAutre    INTEGER CHECK (countAutre >= 0)
);
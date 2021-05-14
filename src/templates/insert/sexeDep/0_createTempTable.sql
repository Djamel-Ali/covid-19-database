DROP TABLE IF EXISTS TempSexesDep CASCADE;
CREATE TABLE TempSexesDep
(
    numDep       CHAR(3),
    jour         DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
    idSexe       INTEGER CHECK ( idSexe = 0 OR idSexe = 1 OR idSexe = 2),
    PRIMARY KEY (numDep, jour, idSexe),
    hospSexe     INTEGER NOT NULL CHECK (hospSexe >= 0),
    reaSexe      INTEGER NOT NULL CHECK (reaSexe >= 0),
    radSexe      INTEGER NOT NULL CHECK (radSexe >= 0),
    dcSexe       INTEGER NOT NULL CHECK (dcSexe >= 0),
    ssrUsldSexe  INTEGER CHECK (ssrUsldSexe >= 0),
    hospConvSexe INTEGER CHECK (hospConvSexe >= 0),
    autreSexe    INTEGER CHECK (autreSexe >= 0)
);
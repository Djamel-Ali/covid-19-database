CREATE TABLE AgesReg
(
    numReg INTEGER REFERENCES Region(numReg),
    jour DATE NOT NULL CHECK (jour <= CURRENT_DATE),
    clAge90 INTEGER NOT NULL CHECK (clAge90 >= 0 AND clAge90 <= 90),
    PRIMARY KEY (numReg, jour, clAge90),
    hospAge INTEGER NOT NULL CHECK (hospAge >= 0),
    reaAge INTEGER NOT NULL CHECK (reaAge >= 0),
    radAge INTEGER NOT NULL CHECK (radAge >= 0),
    dcAge INTEGER NOT NULL CHECK (dcAge >= 0),
    ssrUsldAge INTEGER CHECK (ssrUsldAge >= 0),
    hospConvAge INTEGER CHECK (hospConvAge >= 0),
    autreAge INTEGER CHECK (autreAge >= 0)
);
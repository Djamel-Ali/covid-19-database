CREATE TABLE SexesDep
(
    numDep CHAR(3) REFERENCES Departement(numDep),
    jour DATE NOT NULL CHECK (jour <= CURRENT_DATE),
    idSexe INTEGER REFERENCES Sexe(idSexe),
    PRIMARY KEY (numDep, jour, idSexe),
    hospSexe INTEGER NOT NULL CHECK (hospSexe >= 0),
    reaSexe INTEGER NOT NULL CHECK (reaSexe >= 0),
    radSexe INTEGER NOT NULL CHECK (radSexe >= 0),
    dcSexe INTEGER NOT NULL CHECK (dcSexe >= 0),
    ssrUsldSexe INTEGER CHECK (ssrUsldSexe >= 0), --il faut s'assurer que quand il vaut NULL, 'le CHECK' ne poserait pas de problèmes, ici, c'est ce qu'ils confirment en tout cas: (https://stackoverflow.com/questions/1181824/postgres-constraint-check-and-null-values)
    hospConvSexe INTEGER CHECK (hospConvSexe >= 0),
    autreSexe INTEGER CHECK (autreSexe >= 0)
);
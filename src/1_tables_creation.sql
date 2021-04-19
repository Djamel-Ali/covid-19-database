\echo
\echo ---------+---------+---------+---------+---------
\echo ----> CREATION DES TABLES <----
\echo ---------+---------+---------+---------+---------
\echo
\echo Suppression des anciennes versions des tables
\echo ...
\echo
DROP TABLE IF EXISTS Sexe, Departement, Region, SexesDep, Incidence, AgesReg CASCADE;
DROP DOMAIN IF EXISTS alphanum;

\echo √ fait.
\echo

\echo ---------+---------+---------+---------+---------

\echo Creation des nouvelles versions des tables
\echo ...

CREATE TABLE Sexe
(
    idSexe INTEGER PRIMARY KEY ,
    sexe VARCHAR NOT NULL 
    CHECK ((idSexe = 1 AND LOWER(sexe) = 'masculin') OR 
           (idSexe = 2 AND LOWER(sexe) = 'feminin'))
);

\echo TABLE Sexe créée  √
\echo

-- c.f. Code INSEE des Régions, Wikipédia (https://fr.wikipedia.org/wiki/R%C3%A9gion_fran%C3%A7aise)
-- Et sur data-gouv.fr : https://www.data.gouv.fr/en/datasets/regions-de-france/
CREATE TABLE Region
(
    numReg INTEGER PRIMARY KEY CHECK ((numReg BETWEEN 1 AND 6) OR (numReg BETWEEN 11 AND 94)),
    nomReg VARCHAR NOT NULL
);

\echo TABLE Region créée  √
\echo

create domain alphanum as varchar(20) check (value ~ '^[0-9][a-zA-Z0-9]([0-9])?$'); 
-- France d'outre-mer d'après Wikipédia (https://fr.wikipedia.org/wiki/France_d%27outre-mer)
-- France métropolitaine d'après Wikipedia (https://fr.wikipedia.org/wiki/D%C3%A9partement_fran%C3%A7ais#Liste_des_101_circonscriptions_administratives)
-- Et sur data-gouv.fr : https://www.data.gouv.fr/en/datasets/departements-de-france/
-- avant alphanum : numDep INTEGER PRIMARY KEY CHECK ( (numDep BETWEEN 1 AND 95) OR (numDep BETWEEN 971 AND 989) ),
CREATE TABLE Departement
(
    numDep alphanum PRIMARY KEY,
    nomDep VARCHAR NOT NULL,
    numReg INTEGER REFERENCES Region(numReg)
);

\echo TABLE Departement créée  √
\echo


CREATE TABLE SexesDep
(
    numDep alphanum REFERENCES Departement(numDep),
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

\echo TABLE SexesDep créée  √
\echo


CREATE TABLE Incidence
(
    numDep alphanum REFERENCES Departement(numDep),
    jour DATE NOT NULL CHECK (jour <= CURRENT_DATE),
    PRIMARY KEY (numDep, jour),
    incidHosp INTEGER NOT NULL CHECK (incidHosp >= 0),
    incidRea INTEGER NOT NULL CHECK (incidRea >= 0),
    incidRad INTEGER NOT NULL CHECK (incidRad >= 0),
    incidDc INTEGER NOT NULL CHECK (incidDc >= 0),
    nbSvce INTEGER NOT NULL CHECK (nbSvce >= 0)
);

\echo TABLE Incidence créée  √
\echo


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

\echo TABLE AgesReg créée  √
\echo


\echo
\echo √ fait.
\echo 

\echo ---------+---------+---------+---------+---------
\echo ----> FIN DE LA CREATION DES TABLES <----
\echo ---------+---------+---------+---------+---------
\echo

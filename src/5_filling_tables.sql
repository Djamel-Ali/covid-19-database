\echo
\echo '---------+---------+---------+---------+---------'
\echo '----> REMPLISSAGE DES TABLES <----'
\echo '---------+---------+---------+---------+---------'
\echo

-- populate the tables

\echo Remplissage de la table 'Sexe'
\echo '...'
\echo

INSERT INTO Sexe(idSexe, sexe) VALUES
(1, 'masculin'),
(2, 'feminin');

\echo '---------+---------+---------+---------+---------'
\echo

\echo Remplissage de la table 'Region'
\echo '...'
\echo

COPY Region(numReg , nomReg)
FROM '/home/djamel/covid-19_database/src/data_sources/regions-france.csv'
CSV HEADER;

\echo '---------+---------+---------+---------+---------'
\echo

\echo Remplissage de la table 'Departement'
\echo '...'
\echo

-- Copy from the file into a temporary table 't'
CREATE TEMPORARY TABLE t(nuD alphanum, noD VARCHAR, nuR INTEGER, noR VARCHAR);
COPY t
FROM '/home/djamel/covid-19_database/src/data_sources/departements-france.csv'
CSV HEADER;

-- insert into the definitive table from the temp
INSERT INTO Departement(numDep, nomDep, numReg)
SELECT nuD, noD, nuR
FROM t;

-- Drop temp
DROP TABLE t;
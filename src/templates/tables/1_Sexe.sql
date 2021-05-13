CREATE TABLE Sexe
(
    idSexe INTEGER PRIMARY KEY ,
    sexe VARCHAR NOT NULL
        CHECK ((idSexe = 1 AND LOWER(sexe) = 'masculin') OR
               (idSexe = 2 AND LOWER(sexe) = 'feminin'))
);

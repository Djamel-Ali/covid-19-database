CREATE UNIQUE INDEX index_SexesDep ON SexesDep (numDep, jour, idSexe);
CREATE UNIQUE INDEX index_Incidence ON Incidence (numDep, jour);
CREATE UNIQUE INDEX index_AgeReg ON AgesReg (numReg, jour, clAge90);

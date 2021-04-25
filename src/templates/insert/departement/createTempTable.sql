CREATE TEMPORARY TABLE tempDepartement
(
    numDep CHAR(3),
    nomDep VARCHAR,
    numReg INTEGER,
    nomReg VARCHAR
);

CREATE OR REPLACE FUNCTION insert_departement() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO Departement VALUES (NEW.numDep, NEW.nomDep, NEW.numReg);

    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE TRIGGER InsertTempDepartement
AFTER INSERT ON tempDepartement
FOR EACH ROW EXECUTE FUNCTION insert_departement();


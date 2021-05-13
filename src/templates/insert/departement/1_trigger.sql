CREATE OR REPLACE FUNCTION insert_departement() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO Departement VALUES (NEW.numDep, NEW.nomDep, NEW.numReg);

    RETURN NULL;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS InsertTempDepartement ON tempDepartement;

CREATE TRIGGER InsertTempDepartement
    AFTER INSERT ON tempDepartement
    FOR EACH ROW EXECUTE FUNCTION insert_departement();

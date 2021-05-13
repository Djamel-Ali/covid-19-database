CREATE OR REPLACE FUNCTION insert_departement() RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO Departement VALUES (NEW.numDep, NEW.nomDep, NEW.numReg);

    RETURN NULL;
END
$$ LANGUAGE plpgsql;


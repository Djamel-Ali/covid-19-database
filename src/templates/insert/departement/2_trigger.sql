DROP TRIGGER IF EXISTS InsertTempDepartement ON tempDepartement;

CREATE TRIGGER InsertTempDepartement
    AFTER INSERT ON tempDepartement
    FOR EACH ROW EXECUTE FUNCTION insert_departement();

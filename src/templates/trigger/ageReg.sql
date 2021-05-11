
CREATE TRIGGER NoAddAlreadyExistAgeReg
    BEFORE INSERT ON AgesReg
    FOR EACH ROW EXECUTE
    FUNCTION insert_ageReg();

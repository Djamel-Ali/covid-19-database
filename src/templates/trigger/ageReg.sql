CREATE TRIGGER NoAddAlreadyExistAgeReg
    BEFORE INSERT
    ON AgesReg
    FOR EACH ROW
    EXECUTE PROCEDURE insert_ageReg();

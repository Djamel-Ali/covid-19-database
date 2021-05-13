CREATE TRIGGER NoAddAlreadyExistIncid
    BEFORE INSERT
    ON Incidence
    FOR EACH ROW
EXECUTE
    FUNCTION insert_incidence();

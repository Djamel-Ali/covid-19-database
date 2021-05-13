CREATE TRIGGER NoAddAlreadyExistSexeDep
    BEFORE INSERT
    ON SexesDep
    FOR EACH ROW
EXECUTE
    FUNCTION insert_sexeDep();

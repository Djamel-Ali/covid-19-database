CREATE TRIGGER NoAddAlreadyExistSexeDep
    BEFORE INSERT
    ON SexesDep
    FOR EACH ROW
    EXECUTE PROCEDURE insert_sexeDep();

CREATE TRIGGER NoAddAlreadyExistTempSexeDep
    BEFORE INSERT
    ON TempSexesDep
    FOR EACH ROW
    EXECUTE PROCEDURE insert_sexeDepTemp();

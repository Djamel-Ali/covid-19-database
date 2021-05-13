CREATE TRIGGER NoAddAlreadyExistSexeDep
    BEFORE INSERT
    ON SexesDep
    FOR EACH ROW
EXECUTE
    FUNCTION insert_sexeDep();


CREATE TRIGGER DropTempTableSexeDep
    AFTER INSERT
    ON SexesDep
    FOR EACH STATEMENT
EXECUTE
    FUNCTION check_tmp_total_sexe_dep();

CREATE TRIGGER NoAddAlreadyExistIncid
    BEFORE INSERT
    ON Incidence
    FOR EACH ROW
EXECUTE
    FUNCTION insert_incidence();

-- DELETE ajouté juste par précaution, (mais normalement ce cas
-- ne devrait pas y arriver, car cela veut dire qu'on avait inséré une entrée
--  auparavant dans incidence avec comme clef le couple (numDep, jour),
-- mais on supprime maintenant cette même entrée (DELETE) ; ce qui veut dire
-- (en gros pour notre trigger) qu'il n'y a finalement aucun décès ce jour là
-- et dans ce département là).
CREATE TRIGGER trig_audit_incid_dc
AFTER UPDATE OF incidDc OR DELETE OR INSERT
ON Incidence
FOR EACH ROW
EXECUTE PROCEDURE audit_incid_dc_fun();

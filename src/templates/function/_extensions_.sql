-------------------------------------------------------------------------
-- Remarques:

-- * Ces quelques fonctions ne sont pas utilisées dans ce projet.
-- * Elles ont été écrites lors des préparations de quelqes extensions
--   mais qui ne sont pas encore arrivées à terme.
--------------------------------------------------------------------------


-- get the age group (clAge90 class) knowing age of the person
CREATE OR REPLACE FUNCTION get_age_group(age INTEGER) RETURNS INTEGER AS
$$
BEGIN
    IF (age > 0 AND age < 10) THEN RETURN 9;
    ELSE IF (age >= 10 AND age < 20) THEN RETURN 19;
    ELSE IF (age >= 20 AND age < 30) THEN RETURN 29;
    ELSE IF (age >= 30 AND age < 40) THEN RETURN 39;
    ELSE IF (age >= 40 AND age < 50) THEN RETURN 49;
    ELSE IF (age >= 50 AND age < 60) THEN RETURN 59;
    ELSE IF (age >= 60 AND age < 70) THEN RETURN 69;
    ELSE IF (age >= 70 AND age < 80) THEN RETURN 79;
    ELSE IF (age >= 80 AND age < 90) THEN RETURN 89;
    ELSE RETURN 90;
    END IF;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------

-- get the age knowing the date of birth of the person
CREATE OR REPLACE FUNCTION get_age_group(d_birth TIMESTAMP) RETURNS INTEGER AS
$$
BEGIN
RETURN (SELECT EXTRACT(YEAR FROM (SELECT AGE(d_birth))));
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------

-- un type plus strict que juste CHAR(3) qui sert à typer les numDep
-- (numéros des départements de France)
-- exemples : [Paris : 75], [Haute-Corse : 2B], [La Réunion :	974] ...
CREATE DOMAIN numalpha AS VARCHAR(20) CHECK (VALUE ~ '^[0-9][a-zA-Z0-9]([0-9])?$');

-----------------------------------------------------------------------

-- get numReg knowing numDep
CREATE OR REPLACE FUNCTION get_num_Reg(_numDep numalpha) RETURNS INTEGER AS
$$
BEGIN
    RETURN QUERY
        SELECT numReg FROM Departement WHERE numDep = _numDep;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------

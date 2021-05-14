CREATE OR REPLACE FUNCTION insert_sexeDep() RETURNS TRIGGER AS
$$
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM SexesDep
                  WHERE numDep = NEW.numDep
                    AND jour = NEW.Jour
                    AND idSexe = NEW.idSexe) THEN
        IF NEW.idSexe <> 0 THEN
            RETURN NEW;
        END IF;
        RETURN NULL;
    END IF;

    RETURN NULL;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_sexeDepTemp() RETURNS TRIGGER AS
$$
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM TempSexesDep
                  WHERE numDep = NEW.numDep
                    AND jour = NEW.Jour
                    AND idSexe = NEW.idSexe) THEN
        IF NEW.idSexe <> 0 THEN
            RETURN NEW;
        END IF;
        RETURN NULL;
    END IF;

    RETURN NULL;
END
$$ LANGUAGE plpgsql;




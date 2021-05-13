CREATE OR REPLACE FUNCTION insert_incidence() RETURNS TRIGGER AS
$$
BEGIN
    IF NOT EXISTS(SELECT *
                  FROM Incidence
                  WHERE NumDep = NEW.NumDep
                    AND jour = NEW.Jour) THEN
        RETURN NEW;
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


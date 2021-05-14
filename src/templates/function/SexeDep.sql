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
    END IF;
    RAISE NOTICE 'ALREADY EXIST NO INSERT %', (NEW.*);
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


    END IF;

    UPDATE TempSexesDep
    SET hospSexe    = NEW.hospSexe,
        reaSexe     = NEW.reaSexe,
        radSexe     = NEW.radSexe,
        dcSexe      = NEW.dcSexe,
        ssrUsldSexe = NEW.ssrUsldSexe,
        hospConvSexe= NEW.hospConvSexe,
        autreSexe   = NEW.autreSexe
    WHERE numDep = NEW.numDep
      AND jour = NEW.Jour
      AND idSexe = NEW.idSexe;
    RAISE NOTICE 'ALREADY EXIST UPDATE %', NEW;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;




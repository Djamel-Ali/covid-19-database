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

        INSERT INTO TotalSexeDep VALUES (NEW.*);
        RETURN NULL;
    END IF;

    RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_tmp_total_sexe_dep() RETURNS TRIGGER AS
$$
BEGIN
    IF EXISTS(
            SELECT numDep,
                   jour,
                   COUNT(hospSexe)     AS countHosp,
                   COUNT(reaSexe)      AS countRea,
                   COUNT(radSexe)      AS countRad,
                   COUNT(dcSexe)       AS countDc,
                   COUNT(ssrUsldSexe)  AS countSsrUsldSexe,
                   COUNT(hospConvSexe) AS countHospConvSexe,
                   COUNT(autreSexe)    AS autreSexe
            FROM sexesDep
            GROUP BY numDep, jour

            INTERSECT

            SELECT numDep,
                   jour,
                   countHosp,
                   countRea,
                   countRad,
                   countDc,
                   countSsrUsld,
                   countHospConv,
                   countAutre
            FROM TotalSexeDep) THEN
        RAISE EXCEPTION 'Total different';
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;



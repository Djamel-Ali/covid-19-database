CREATE OR REPLACE FUNCTION check_total_sexeDep() RETURNS BOOLEAN AS
$$
BEGIN
    RETURN EXISTS(
            SELECT numDep,
                   jour,
                   COUNT(hospSexe)     AS countHosp,
                   COUNT(reaSexe)      AS countRea,
                   COUNT(radSexe)      AS countRad,
                   COUNT(dcSexe)       AS countDc,
                   COUNT(ssrUsldSexe)  AS countSsrUsldSexe,
                   COUNT(hospConvSexe) AS countHospConvSexe,
                   COUNT(autreSexe)    AS countAutreSexe
            FROM tempSexesdep
            WHERE idSexe != 0
            GROUP BY numDep, jour

            INTERSECT

            SELECT numDep,
                   jour,
                   hospSexe     AS countHosp,
                   reaSexe      AS countRea,
                   radSexe      AS countRad,
                   dcSexe       AS countDc,
                   ssrUsldSexe  AS countSsrUsldSexe,
                   hospConvSexe AS countHospConvSexe,
                   autreSexe    AS countAutreSexe
            FROM tempSexesdep
            WHERE idSexe = 0
        );
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_sexeDep_from_temp()
    RETURNS VOID AS
$$
BEGIN
    IF (SELECT check_total_sexeDep()) THEN
        RAISE EXCEPTION 'Total sexe different total id sexe 0';
    END IF;

    INSERT INTO SexesDep
    SELECT * FROM TempSexesDep
        WHERE idSexe != 0;

    DELETE FROM TempSexesdep;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION list_sexeDep_correct()
    RETURNS
        TABLE
        (
            numDep CHAR(3),
            jour   DATE
        )
AS
$$
BEGIN
    CREATE OR REPLACE TEMP VIEW intersectionViewSexeDepTotal AS
    (
        SELECT numDep,
               jour,
               SUM(hospSexe)     AS countHosp,
               SUM(reaSexe)      AS countRea,
               SUM(radSexe)      AS countRad,
               SUM(dcSexe)       AS countDc,
               SUM(ssrUsldSexe)  AS countSsrUsldSexe,
               SUM(hospConvSexe) AS countHospConvSexe,
               SUM(autreSexe)    AS countAutreSexe
        FROM tempSexesdep
        WHERE idSexe != 0
        GROUP BY numDep, jour
        ORDER BY jour, numDep
    )
    INTERSECT
    (
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
        ORDER BY jour, numDep
    );

    RETURN QUERY (
        SELECT intersectionViewSexeDepTotal.numDep,
               intersectionViewSexeDepTotal.jour
        FROM intersectionViewSexeDepTotal
        ORDER BY jour, numDep
    );
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_sexeDep_from_temp()
    RETURNS VOID AS
$$
BEGIN
    CREATE OR REPLACE TEMP VIEW toInsert AS
    SELECT * FROM list_sexeDep_correct();

    INSERT INTO SexesDep
    SELECT TempSexesDep.numDep,
           TempSexesDep.jour,
           idSexe,
           hospSexe,
           reaSexe,
           radSexe,
           dcSexe,
           ssrUsldSexe,
           hospConvSexe,
           autreSexe
    FROM TempSexesDep
             JOIN toInsert ON toInsert.numDep = TempSexesDep.numDep AND
                              toInsert.jour = TempSexesDep.jour
    WHERE idSexe != 0;

    DELETE
    FROM TempSexesdep
    WHERE numDep IN (SELECT numDep FROM toInsert)
      AND jour IN (SELECT jour FROM toInsert);
END
$$ LANGUAGE plpgsql;

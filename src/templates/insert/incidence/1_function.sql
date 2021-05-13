CREATE OR REPLACE FUNCTION allRegIncidInDep()
    RETURNS BOOLEAN AS
$$
BEGIN
     RETURN EXISTS(
        SELECT numReg, nomReg, incidRea
        FROM TempIncidReg

        INTERSECT

        SELECT region.numReg,
               nomReg,
               Sum(incidRea) as incidRea
        FROM TempIncidDep
                 JOIN departement
                      ON departement.numDep = TempIncidDep.numDep
                 JOIN region
                      ON region.numReg = departement.numReg
        GROUP BY region.numReg
    );
END
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION InsertIncidence()
    RETURNS VOID AS
$$
BEGIN
    IF (SELECT allRegIncidInDep()) THEN
        RAISE EXCEPTION 'intersection not empty on intersection dep and Reg';
    END IF;

    INSERT INTO Incidence (numDep,
                           jour,
                           incidHosp,
                           incidRea,
                           incidDc,
                           incidRad,
                           nbSvce)
    SELECT TempIncidDep.numDep,
           TempIncidDep.jour,
           incidHosp,
           incidRea,
           incidDc,
           incidRad,
           TempService.nbSvce
    FROM TempIncidDep
             JOIN TempService
                  ON TempService.numDep = TempIncidDep.numDep AND
                     TempService.jour = TempIncidDep.jour;

    DELETE FROM TempIncidDep;
    DELETE FROM TempIncidReg;
    DELETE FROM TempIncidReg;
END
$$ LANGUAGE plpgsql;

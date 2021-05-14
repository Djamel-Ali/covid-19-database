CREATE OR REPLACE FUNCTION sexeDepBetweenTwoDay(startDate DATE, endDate DATE)
    RETURNS SexesDep AS
$$
BEGIN
    RETURN
        (
            SELECT *
            FROM SexesDep
            WHERE jour BETWEEN startDate AND endDate
        );
END
$$ LANGUAGE plpgsql;

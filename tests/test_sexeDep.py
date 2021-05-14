import psycopg2
import pytest

from .tools import exec_file, FILLER, DIR_CSV

psql = FILLER.psql


def recreate_temp_sexeDep():
    psql.execute(
    """
    DROP TABLE IF EXISTS TempSexesDep CASCADE;
    CREATE TABLE TempSexesDep
    (
        numDep       CHAR(3),
        jour         DATE    NOT NULL CHECK (jour <= CURRENT_DATE),
        idSexe       INTEGER CHECK ( idSexe = 0 OR idSexe = 1 OR idSexe = 2),
        PRIMARY KEY (numDep, jour, idSexe),
        hospSexe     INTEGER NOT NULL CHECK (hospSexe >= 0),
        reaSexe      INTEGER NOT NULL CHECK (reaSexe >= 0),
        radSexe      INTEGER NOT NULL CHECK (radSexe >= 0),
        dcSexe       INTEGER NOT NULL CHECK (dcSexe >= 0),
        ssrUsldSexe  INTEGER CHECK (ssrUsldSexe >= 0),
        hospConvSexe INTEGER CHECK (hospConvSexe >= 0),
        autreSexe    INTEGER CHECK (autreSexe >= 0)
    );
    """)


def test_wrong_sexe_dep_total():
    recreate_temp_sexeDep()
    FILLER.fill_sexe_dep(DIR_CSV / "sexe_dep_wrong_total.csv")
    psql.execute("SELECT * FROM TempSexesDep;")
    assert len(psql.get_iterator()) == 3

    psql.execute("SELECT count(jour) FROM SexesDep "
                 "WHERE jour='2019-01-01' "
                 "GROUP BY jour;")
    assert psql.get_iterator() == []


def test_good_sexe_dep_total():
    recreate_temp_sexeDep()
    FILLER.fill_sexe_dep(DIR_CSV / "sexe_dep_good_total.csv")
    psql.execute("SELECT * FROM TempSexesDep;")
    assert len(psql.get_iterator()) == 0

    psql.execute("SELECT count(jour) FROM SexesDep "
                 "WHERE jour='2019-01-01' "
                 "GROUP BY jour;")
    assert psql.get_iterator() == [(2,)]

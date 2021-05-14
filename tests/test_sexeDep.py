import psycopg2
import pytest

from .tools import exec_file, FILLER, DIR_CSV


def test_wrong_sexe_dep_total():
    FILLER.fill_sexe_dep(DIR_CSV / "sexe_dep_wrong_total.csv")
    psql = FILLER.psql
    psql.execute("SELECT * FROM TempSexesDep;")
    assert len(psql.get_iterator()) == 3

    psql.execute("SELECT count(jour) FROM SexesDep "
                 "WHERE jour='2019-01-01' "
                 "GROUP BY jour;")
    assert psql.get_iterator() == []

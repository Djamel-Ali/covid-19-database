import psycopg2
import pytest

from .tools import exec_file


def test_insert_already_exist_region():
    with pytest.raises(psycopg2.ProgrammingError):
        exec_file("insert_already_exist_departement")

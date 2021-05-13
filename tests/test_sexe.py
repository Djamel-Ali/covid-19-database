import psycopg2
import pytest

from .tools import exec_file


def test_insert_wrong_sexe():
    with pytest.raises(psycopg2.ProgrammingError):
        exec_file("insert_wrong_sexe")


def test_insert_wrong_sexe_id():
    with pytest.raises(psycopg2.ProgrammingError):
        exec_file("insert_wrong_sexe_id")


def test_update_insert_wrong_sexe():
    with pytest.raises(psycopg2.IntegrityError):
        exec_file("update_wrong_sexe")

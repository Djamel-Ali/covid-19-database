import sys

import psycopg2
from .Template import Template


class Psql:
    def __init__(self, verbose=False, **params: dict):
        self.VERBOSE = verbose
        self.connection = None
        self.connection = psycopg2.connect(**params)
        self.cursor = self.connection.cursor()

    def execute(self, command: str,
                commit: bool = False,
                auto_rollback: bool = False):
        try:
            if self.VERBOSE:
                print("----- execute -----")
                print(command)
                print("-------------------")

            self.cursor.execute(command)
        except Exception as err:
            print("ERROR execute:", command, sep='\n', file=sys.stderr)
            if auto_rollback:
                self.rollback()
            raise err

        if commit:
            self.commit()

    def rollback(self):
        self.cursor.execute("ROLLBACK;")

    def execute_template(self, template: Template,
                         params_template=None,
                         commit: bool = False,
                         auto_rollback: bool = False):
        if params_template is None:
            params_template = dict()

        self.execute(template.replace(**params_template), commit, auto_rollback)

    def copy(self, file_stream, table, sep=',', columns=None):
        if self.VERBOSE:
            print("----- copy -----")
            print(f"copy csv file: \"{file_stream.name}\"")
            print(f"use separator \"{sep}\", in table \"{table}\"")
            print("-------------------")
        self.cursor.copy_from(file_stream, table, sep, columns=columns)

    def get_iterator(self):
        return self.cursor.fetchall()

    def commit(self):
        self.connection.commit()

    def close(self):
        self.cursor.close()
        self.connection.close()

    def __del__(self):
        if self.connection is not None:
            self.close()

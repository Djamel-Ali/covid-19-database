import sys
from os import system

import psycopg2
from .Template import Template


class Psql:
    section_psql = "postgresql"

    def __init__(self, **params: dict):
        self.connection = psycopg2.connect(**params)
        self.cursor = self.connection.cursor()

    @staticmethod
    def get_params(config) -> dict:
        return {k: v for k, v in config.items(Psql.section_psql)}

    def execute(self, command: str, commit: bool = False):
        try:
            self.cursor.execute(command)
        except Exception as err:
            print("ERROR execute:", command, sep='\n', file=sys.stderr)
            raise err

        if commit:
            self.commit()

    def execute_template(self, template: Template, params_template: dict,
                         commit: bool = False):
        self.execute(template.replace(**params_template), commit)

    def commit(self):
        self.connection.commit()

    def __del__(self):
        if self.connection is not None:
            self.connection.close()

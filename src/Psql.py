import psycopg2
from Template import Template


class Psql:
    section_psql = "postgresql"

    def __init__(self, **params: dict):
        self.connection = psycopg2.connect(**params)
        self.cursor = self.connection.cursor()

    @staticmethod
    def get_params(config):
        if not config.has_section():
            raise Exception(f"No section {Psql.section_psql} in config")
        return {k: v for k, v in config.items(Psql.section_psql)}

    def execute(self, command: str, commit: bool = False):
        self.cursor.execute(command)
        if commit:
            self.commit()

    def execute_template(self, template: Template, params_template: dict,
                         commit: bool = False):
        self.execute(template.replace(**params_template), commit)

    def commit(self):
        self.cursor.commit()

    def __del__(self):
        self.connection.close()

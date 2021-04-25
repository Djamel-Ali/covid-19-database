from .TemplateDir import TEMPLATES_DIR, TemplateDir
from .Psql import Psql
from .print_func import print_head

DIR_INSERT = TEMPLATES_DIR / "insert"

class Filler:
    def __init__(self, psql: Psql):
        self.psql = psql
        self.template_dir = TemplateDir(DIR_INSERT)

    def fill_sexe(self):
        print("Fill Sexe table")
        template = self.template_dir.get_template("sexe")
        self.psql.execute_template(template)

    def fill_all(self):
        print_head("DEBUT REPLISSAGE DES TABLES")
        self.fill_sexe()

        print_head("FIN REPLISSAGE DES TABLES")

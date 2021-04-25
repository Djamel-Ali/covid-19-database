from . import Config
from .print_func import print_head
from .TemplateDir import TemplateDir, TEMPLATES_DIR

DIR_INSERT = TEMPLATES_DIR / "insert"

class Filler:
    def __init__(self, config: Config):
        self.config = config
        self.template_dir = TemplateDir(DIR_INSERT)

    @property
    def psql(self):
        return self.config.psql

    @property
    def path_data_source(self):
        return self.config.path_data_source

    def fill_sexe(self):
        print("Fill Sexe table")
        template = self.template_dir.get_template("sexe")
        self.psql.execute_template(template)


    @property
    def path_region(self):
        return self.path_data_source / "regions-france.csv"

    def fill_region(self):
        print(f"Fill Region table with file [{self.path_region}]")
        with open(self.path_region, 'r') as f:
            next(f)
            self.psql.copy(f, "Region", ',')

    def fill_all(self):
        print_head("DEBUT REPLISSAGE DES TABLES")
        self.fill_sexe()
        self.fill_region()

        print_head("FIN REPLISSAGE DES TABLES")

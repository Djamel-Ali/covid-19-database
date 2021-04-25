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
        print("Remplissage de la table Sexe")
        template = self.template_dir.get_template("sexe")
        self.psql.execute_template(template)

    def __fill_csv_simple(self, table, path):
        print(f"Remplissage de la table {table} "
              f"avec le fichier [{path}]")
        with open(path, 'r') as f:
            # skip header
            next(f)
            self.psql.copy(f, table, ',')

    @property
    def path_region(self):
        return self.path_data_source / "regions-france.csv"

    def fill_region(self):
        self.__fill_csv_simple("Region", self.path_region)

    @property
    def path_departement(self):
        return self.path_data_source / "departements-france.csv"

    def fill_departement(self):
        template_dir = TemplateDir(DIR_INSERT / "departement")
        template_create = template_dir.get_template("createTempTable")
        template_drop = template_dir.get_template("dropTempTable")

        self.psql.execute_template(template_create)
        self.__fill_csv_simple("tempDepartement", self.path_departement)
        self.psql.execute_template(template_drop)

    def fill_all(self):
        print_head("DEBUT REPLISSAGE DES TABLES")
        self.fill_sexe()
        self.fill_region()
        self.fill_departement()

        print_head("FIN REPLISSAGE DES TABLES")

from . import Config, DIR_NAME
from .csv_tool import *
from .print_func import print_head
from .TemplateDir import TemplateDir, TEMPLATES_DIR

DIR_INSERT = TEMPLATES_DIR / "insert"


class Filler:
    def __init__(self, config: Config):
        self.config = config
        self.template_dir = TemplateDir(DIR_INSERT)

    def fill(self, name, path):
        INSERTER = {
            "age": lambda : self.fill_age_reg(path),
            # "incid": lambda : ,
            # "sexe": lambda : ,
            # "hospi_new": lambda : ,
            # "etabli": lambda :
        }
        INSERTER.get(name, lambda : None)() #[name]()

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

    def __fill_csv_simple(self, path, table, **kwargs):
        print(f"Remplissage de la table {table} "
              f"avec le fichier [{path}]")
        with open(path, 'r') as f:
            # skip header
            next(f)
            self.psql.copy(f, table, **kwargs)

    def __fill_csv_apply_func(self, path: str, table: str,
                              columns: tuple,
                              funcs: tuple,
                              sep=",",
                              update=False):
        assert len(columns) == len(funcs)

        print(f"Remplissage de la table {table} "
              f"avec le fichier [{path}]")

        with open(path, 'r') as f:
            # skip header
            next(f)
            values = []
            for line in f.readlines():
                line = tuple([f(l) for l, f in zip(line.split(sep), funcs)])
                assert len(line) == len(funcs)
                values.append(f"({','.join(line)})")

            values_str = ",\n".join(values)
        request = f"INSERT INTO {table} ({','.join(columns)}) VALUES\n" \
                  f"{values_str};"
        self.psql.execute(command=request)

    @property
    def path_region(self):
        return self.path_data_source / "regions-france.csv"

    def fill_region(self):
        self.__fill_csv_simple(self.path_region, "Region")

    @property
    def path_departement(self):
        return self.path_data_source / "departements-france.csv"

    def fill_departement(self):
        template_dir = TemplateDir(DIR_INSERT / "departement")
        template_create = template_dir.get_template("createTempTable")
        template_drop = template_dir.get_template("dropTempTable")

        self.psql.execute_template(template_create)
        self.__fill_csv_simple(self.path_departement, "tempDepartement")
        self.psql.execute_template(template_drop)

    @property
    def path_age_reg(self):
        files = (self.path_data_source / DIR_NAME["age"]).iterdir()
        return list(sorted(files))[0]

    @property
    def info_col_age(self):
        return (
            ("numReg", str_to_int),
            ("clAge90", str_to_int),
            ("jour", lambda x: to_date(x, "YYYY-MM-DD")),
            ("hospAge", str),
            ("reaAge", str),
            ("hospConvAge", int_or_null),
            ("ssrUsldAge", int_or_null),
            ("autreAge", int_or_null),
            ("radAge", str),
            ("dcAge", str))

    @property
    def columns_age_reg(self):
        return tuple([x[0] for x in self.info_col_age])

    @property
    def funcs_age_reg(self):
        return tuple([x[1] for x in self.info_col_age])

    def fill_age_reg(self, file_path=None):
        if file_path is None:
            file_path = self.path_age_reg
        self.__fill_csv_apply_func(file_path,
                                   table="AgesReg",
                                   columns=self.columns_age_reg,
                                   funcs=self.funcs_age_reg,
                                   sep=";", update=True)

    def fill_all(self):
        print_head("DEBUT REMPLISSAGE DES TABLES")
        self.fill_sexe()
        self.fill_region()
        self.fill_departement()
        self.fill_age_reg()

        print_head("FIN REPLISSAGE DES TABLES")


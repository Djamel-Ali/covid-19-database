from . import Config, DIR_NAME
from .csv_tool import *
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

    def exec_template_file(self, name):
        TemplateDir(DIR_INSERT / name).exec_all_file(self.psql)

    def __fill_csv_simple(self, path, table, **kwargs):
        print(f"Remplissage de la table {table} "
              f"avec le fichier [{path}]")
        with open(path, 'r') as f:
            # skip header
            next(f)
            self.psql.copy(f, table, **kwargs)

    def __fill_csv_apply_func(self, path: str, table: str,
                              info: tuple, sep=","):
        columns = [x[0] for x in info]
        funcs = [x[1] for x in info]

        print(f"Remplissage de la table {table} "
              f"avec le fichier [{path}]")

        with open(path, 'r') as f:
            # skip header
            next(f)
            values = []
            for line in f.readlines():
                line = tuple([f(l) for l, f in zip(line.split(sep), funcs)])
                assert len(line) == len(funcs), f"{len(line)} != {len(funcs)}"
                values.append(f"({', '.join(line)})")

            values_str = ",\n".join(values)
        request = f"INSERT INTO {table} ({','.join(columns)}) VALUES\n" \
                  f"{values_str};"
        self.psql.execute(command=request)

    def __recent_file_dir(self, name: str):
        files = (self.path_data_source / DIR_NAME[name]).iterdir()
        return max(files)

    @property
    def path_region(self):
        return self.path_data_source / "regions-france.csv"

    def fill_region(self):
        self.__fill_csv_simple(self.path_region, "Region")

    @property
    def path_departement(self):
        return self.path_data_source / "departements-france.csv"

    def fill_departement(self):
        self.exec_template_file("departement")
        self.__fill_csv_simple(self.path_departement, "tempDepartement")

    @property
    def path_age_reg(self):
        return self.__recent_file_dir("age")

    @property
    def info_age_reg(self):
        return (("numReg", str_to_int),
                ("clAge90", str_to_int),
                ("jour", to_date),
                ("hospAge", to_int),
                ("reaAge", to_int),
                ("hospConvAge", int_or_null),
                ("ssrUsldAge", int_or_null),
                ("autreAge", int_or_null),
                ("radAge", to_int),
                ("dcAge", to_int))

    def fill_age_reg(self, file_path=None):
        if file_path is None:
            file_path = self.path_age_reg
        self.__fill_csv_apply_func(file_path,
                                   table="AgesReg",
                                   info=self.info_age_reg,
                                   sep=";")

    @property
    def path_sexe_dep(self):
        return self.__recent_file_dir("sexe")

    @property
    def info_sexe_dep(self):
        return (("numDep", str_to_str),
                ("idSexe", str_to_int),
                ("jour", str_to_date),
                ("hospSexe", to_str),
                ("reaSexe", to_int),
                ("hospConvSexe", int_or_null),
                ("ssrUsldSexe", int_or_null),
                ("autreSexe", int_or_null),
                ("radSexe", to_int),
                ("dcSexe", to_int))

    def fill_sexe_dep(self, file_path=None):
        if file_path is None:
            file_path = self.path_sexe_dep

        self.exec_template_file("sexeDep")

        self.__fill_csv_apply_func(file_path,
                                   table="TempSexesDep",
                                   info=self.info_sexe_dep,
                                   sep=";")
        self.psql.execute("SELECT insert_sexeDep_from_temp();")


    @property
    def path_incid_dep(self):
        return self.__recent_file_dir("incid_dep")

    @property
    def path_incid_reg(self):
        return self.__recent_file_dir("incid_reg")

    @property
    def path_service(self):
        return self.__recent_file_dir("service")

    @property
    def info_incid_dep(self):
        return \
            (
                ("numDep", str_to_str),
                ("jour", to_date),
                ("incidHosp", to_int),
                ("incidRea", to_int),
                ("incidDc", to_int),
                ("incidRad", to_int),
            )

    def fill_incid_dep_tmp(self, path=None):
        if path is None:
            path = self.path_incid_dep

        self.__fill_csv_apply_func(path, "TempIncidDep",
                                   self.info_incid_dep, sep=';')

    def fill_incid_reg_tmp(self, path=None):
        if path is None:
            path = self.path_incid_reg

        self.__fill_csv_simple(path, "TempIncidReg", sep=';')

    @property
    def info_service(self):
        return \
            (
                ("numDep", str_to_str),
                ("jour", to_date),
                ("nbSvce", to_int),
            )

    def fill_service_tmp(self, path=None):
        if path is None:
            path = self.path_service

        self.__fill_csv_apply_func(path, "TempService",
                                   self.info_service, sep=';')

    def fill_incidence(self, incid_dep=None, incid_reg=None, service_file=None):
        self.exec_template_file("incidence")

        print("Remplissage de la table Incidence")

        self.fill_incid_dep_tmp(incid_dep)
        self.fill_incid_reg_tmp(incid_reg)
        self.fill_service_tmp(service_file)
        self.psql.commit()
        self.psql.execute("SELECT InsertIncidence();")

    def fill_all(self):
        print_head("REMPLISSAGE DES TABLES")
        self.fill_sexe()
        self.fill_region()
        self.fill_departement()
        self.psql.commit()

        self.fill_age_reg()
        self.fill_sexe_dep()
        self.fill_incidence()

        self.psql.commit()

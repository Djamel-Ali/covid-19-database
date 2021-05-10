from argparse import ArgumentParser
from configparser import ConfigParser
from pathlib import Path

from .Psql import Psql

SECTION_DATA = "data"
KEY_SOURCE = "source"
SECTION_POSTGRES = "postgresql"

DIR_NAME = {
    "incid": "incid",
    "sexe": "hospit_sexe",
    "hospi_new": "hospit_nouveau",
    "age": "hospit_cls_age",
    "etabli": "hospit_etablissement"
}


class Config(ConfigParser):
    def __init__(self):
        super().__init__()
        self.read(self.arg_parse())
        self.__data_source = None
        self.__psql = None

    @property
    def psql(self):
        if self.__psql is None:
            self.__psql = Psql(**self.psql_param)
        return self.__psql

    @property
    def psql_param(self) -> dict:
        dict = {k: v for k, v in self.items(SECTION_POSTGRES)}
        if "verbose" in self[SECTION_POSTGRES]:
            dict["verbose"] = self.getboolean(SECTION_POSTGRES, "verbose")
        return dict

    @property
    def path_data_source(self):
        if self.__data_source is None:
            self.__data_source = Path(self[SECTION_DATA][KEY_SOURCE])
        return self.__data_source

    @staticmethod
    def arg_parse():
        parser = ArgumentParser()
        parser.add_argument("-c", "--config_file",
                            help="config file used",
                            default="database.ini")
        args = parser.parse_args()
        return Path(args.config_file)

from argparse import ArgumentParser
from configparser import ConfigParser


def parse():
    parser = ArgumentParser()
    parser.add_argument("-c", "--config_file",
                        help="config file used",
                        default="database.ini")
    args = parser.parse_args()
    return config(args.config_file)


def config(filename):
    parser = ConfigParser()
    parser.read(filename)
    return parser

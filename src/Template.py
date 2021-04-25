from pathlib import Path
import re


class Template:
    regex_name = re.compile("(\d_)?(.*)\.sql")

    def __init__(self, path: Path):
        self.__path = path
        with open(self.path, 'r') as file:
            self.content = file.read()
        groups_regex = Template.regex_name.search(self.get_name_file()).groups()
        self.__priority = groups_regex[0]
        self.__name = groups_regex[1]

    @property
    def path(self):
        return self.__path

    @property
    def priority(self):
        return self.__priority

    @property
    def name(self):
        return self.__name

    def get_name_file(self):
        return self.path.name

    def replace(self, **kwargs) -> str:
        return self.content.format(**kwargs)

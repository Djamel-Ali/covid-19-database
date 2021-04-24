from pathlib import Path
import re


class Template:
    regex_name = re.compile("\d_(.*)\.sql")

    def __init__(self, path: Path):
        self.path = path
        with open(self.path, 'r') as file:
            self.content = file.read()

    def get_name_file(self):
        return self.path.name

    def get_name(self):
        return Template.regex_name.search(self.get_name_file()).groups()[0]

    def replace(self, **kwargs) -> str:
        return self.content.format(**kwargs)

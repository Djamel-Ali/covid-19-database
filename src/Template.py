from pathlib import Path


class Template:
    def __init__(self, path: Path):
        with open(path, 'r') as file:
            self.content = file.read()

    def replace(self, dict_var: dict) -> str:
        return self.content.format(**dict_var)

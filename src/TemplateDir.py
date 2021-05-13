from pathlib import Path
from .Template import Template

TEMPLATES_DIR = Path(__file__).parent / "templates"


class TemplateDir:
    def __init__(self, path: Path = TEMPLATES_DIR):
        self.path = path

    def get_template(self, name):
        path_file = self.path / (name + ".sql")
        return Template(path_file)

    def iter_file(self):
        return sorted(self.path.iterdir())

    def iter_template(self):
        return map(Template, self.iter_file())

    def exec_all_file(self, psql):
        for template in self.iter_template():
            psql.execute_template(template)

from src.print_func import print_head
from src.Psql import Psql
from src.TemplateDir import TemplateDir, TEMPLATES_DIR

DIR_TABLES = TEMPLATES_DIR / "function"


def create_functions(psql: Psql, dir=DIR_TABLES):
    print_head("DEBUT CREATION DES FONCTIONS")

    template_dir = TemplateDir(dir)
    it = template_dir.iter_template()
    for template in it:
        print("Creation des fonctions:", template.name)
        psql.execute_template(template, {})

    print_head("FIN DE CREATION DES FONCTIONS")

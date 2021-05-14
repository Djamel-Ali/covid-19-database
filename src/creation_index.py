from src.print_func import print_head
from src.Psql import Psql
from src.TemplateDir import TemplateDir, TEMPLATES_DIR

DIR_TABLES = TEMPLATES_DIR / "index"


def create_indexs(psql: Psql, dir=DIR_TABLES):
    print_head("CREATION DES INDEXS")

    template_dir = TemplateDir(dir)
    it = template_dir.iter_template()
    template = next(it)
    print("creation de l'index avec le fichier: ", template.name)
    psql.execute_template(template, {})

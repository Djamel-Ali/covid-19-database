from src.print_func import print_head
from src.TemplateDir import TemplateDir, TEMPLATES_DIR
from src.Psql import Psql

DIR_TABLES = TEMPLATES_DIR / "tables"

def create_tables(psql: Psql, dir=DIR_TABLES):
    print_head("CREATION DES TABLES")

    template_dir = TemplateDir(dir)
    it = template_dir.iter_template()
    drop_template = next(it)
    print("Suppression des anciennes tables")
    psql.execute_template(drop_template)
    for template in it:
        print("Creation de la table:", template.name)
        psql.execute_template(template)

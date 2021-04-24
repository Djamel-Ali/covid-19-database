from .print_func import print_head
from .TemplateDir import TemplateDir, TEMPLATES_DIR
from .Psql import Psql

DIR_TABLES = TEMPLATES_DIR / "tables"


def create_table(psql: Psql, dir=DIR_TABLES):
    print_head("DEBUT CREATION DES TABLES")

    template_dir = TemplateDir(dir)
    it = template_dir.iter_template()
    drop_template = next(it)
    print("Suppression des anciennes tables")
    psql.execute_template(drop_template, {})

    for template in it:
        name = template.get_name()
        print("Creation de la table:", name)
        psql.execute_template(template, {})
    print("Commit à la base de toutes les tables...")

    print_head("FIN DE CREATION DES TABLES")

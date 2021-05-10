from src.print_func import print_head
from src.Psql import Psql
from src.TemplateDir import TemplateDir, TEMPLATES_DIR

DIR_TABLES = TEMPLATES_DIR / "trigger"


def create_triggers(psql: Psql, dir=DIR_TABLES):
    print_head("DEBUT CREATION DES TRIGGERS")

    template_dir = TemplateDir(dir)
    it = template_dir.iter_template()
    for template in it:
        print("Creation des triggers:", template.name)
        psql.execute_template(template, {})

    print_head("FIN DE CREATION DES TRIGGERS")

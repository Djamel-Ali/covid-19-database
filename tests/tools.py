from pathlib import Path
from src import Config, Filler
from src.TemplateDir import TemplateDir

CUR_DIR = Path(__file__).parent
TEMPLATES_DIR = CUR_DIR / "templates"
CONFIG_FILE = CUR_DIR / "database.ini"

CONFIG = Config(CONFIG_FILE)
PSQL = CONFIG.psql
TEMPLATE_TESTS = TemplateDir(TEMPLATES_DIR)
FILLER = Filler(CONFIG)

DIR_CSV = CUR_DIR / "csv_files"

def exec_file(file_name: str, psql=PSQL, template_dir=TEMPLATE_TESTS):
    psql.execute_template(template_dir.get_template(file_name),
                          auto_rollback=True)
    psql.commit()
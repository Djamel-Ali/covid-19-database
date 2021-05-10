from src import Config, get_infos, save

DIR_NAME = {
    "incid": "incid",
    "sexe": "hospit_sexe",
    "hospi_new": "hospit_nouveau",
    "age": "hospit_cls_age",
    "etabli": "hospit_etablissement"
}

if __name__ == "__main__":
    config = Config()

    infos = get_infos()
    for name, info in infos.items():
        save(config.path_data_source / DIR_NAME[name], *info)

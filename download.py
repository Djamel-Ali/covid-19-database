from src import Config, get_infos, save, DIR_NAME, Filler



if __name__ == "__main__":
    config = Config()
    filler = Filler(config)

    map_path = {}
    for name, info in get_infos().items():
        map_path[name] = save(config.path_data_source / DIR_NAME[name], *info)

    if config.download_insert:
        filler.fill_age_reg(map_path["age"])
        filler.fill_sexe_dep(map_path["sexe"])
        filler.fill_incidence(map_path["incid_dep"],
                              map_path["incid_reg"],
                              map_path["service"])

from src import Config, get_infos, save, DIR_NAME, Filler

if __name__ == "__main__":
    config = Config()
    filler = Filler(config)

    infos = get_infos()
    for name, info in infos.items():
        path = save(config.path_data_source / DIR_NAME[name], *info)
        if config.download_insert:
            filler.fill(name, path)

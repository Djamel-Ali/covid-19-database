from src import Config, create_table, Filler

if __name__ == '__main__':
    # init psql
    config = Config()
    psql = config.psql
    psql.VERBOSE = True   # TODO rm

    # creation table
    create_table(psql)
    psql.commit()

    # function
    # TODO
    psql.commit()

    # trigger
    #TODO
    psql.commit()

    # filling
    filler = Filler(config)
    filler.fill_all()
    psql.commit()

    #close connection
    psql.close()

from src import \
    Config, \
    create_tables, \
    create_functions, \
    create_triggers, \
    Filler

if __name__ == '__main__':
    # init psql
    config = Config()
    psql = config.psql

    # creation table
    create_tables(psql)
    psql.commit()

    # function
    create_functions(psql)
    psql.commit()

    # trigger
    create_triggers(psql)
    psql.commit()

    # filling
    filler = Filler(config)
    filler.fill_all()
    psql.commit()

    #close connection
    psql.close()

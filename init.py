from src import *

if __name__ == '__main__':
    # init psql
    config = Config()
    psql = config.psql
    psql.VERBOSE = True # TODO rm

    # creation table
    create_table(psql)

    # function
    # TODO

    # trigger
    # TODO

    # filling
    filler = Filler(config)
    filler.fill_all()

    print("commit a la base.")
    psql.commit()
    psql.close()

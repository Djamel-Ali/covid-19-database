from src import *


def init_psql():
    config = parse()
    params = Psql.get_params(config)
    return Psql(**params)


if __name__ == '__main__':
    # init psql
    psql = init_psql()

    # creation table
    create_table(psql)

    # function
    # TODO

    # trigger
    # TODO

    # filling
    filler = Filler(psql)
    filler.fill_all()

    print("commit a la base.")
    psql.commit()
    #psql.close()

from src import Psql, parse, create_table

if __name__ == '__main__':
    config = parse()
    params = Psql.get_params(config)
    psql = Psql(**params)

    create_table(psql)
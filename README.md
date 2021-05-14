# BDA -- Covid-19 - Data Base

## Objectif

Ce projet ce concentre les données hospitalière du covid-19. Disponible sur le 
site du [gouverment](https://www.data.gouv.fr/fr/datasets/donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/#). \
Différents sont script python sont disponibles pour pouvoir utiliser facilement
ces données.

## Modélisation

![modélisation](/Documents/img/Diag_entite_association_projet_BDDA.jpg)

## Script

Les scripts utilisé sont en [Python 3.9](https://www.python.org/downloads/release/python-390/), et utilise un
environment [Pipenv](https://pypi.org/project/pipenv/). Et
utilise [psycopg2](https://www.psycopg.org/docs/) pour géré la base postgres
facilement.

### [Pipenv](https://pypi.org/project/pipenv/)

Installer pipenv dans votre environment python global avec la commande :
```shell
$ python -m pip install pipenv
```
(attention a utilisé python3.9)

Pour initialiser l'environnement :

```shell
$ pipenv install
```

Pour entrer dans l'environnement vous pouvez faire :

```shell
$ pipenv shell
(env) $
```

Pour exécuter des command sans entrée dans l'environnement utilisé la commande :

```shell
$ pipenv run ...
```

### Initialisation de la base

Pour initialiser la base de donnée avec le scipt [`init.py`](init.py).

```shell
(env) $ python init.py
```

### Téléchargement des données

Pour lancer le téléchargement des derniers fichier utilisé le
script [`dowload.py`](download.py).

```shell
(env) $ python download.py
```

### [Fichier Configuration](database.ini)

Les scripts précédent utilise un fichier de
configuration [database.init](database.ini) par défault.\
Pour le modifié, il suffit d'ajouter l'argument `--config_file`.

#### Clef
- **postgres**
  - **dbname** \
    Nom de la base de donnée
  - **user** \
    Nom de l'utilisateur
  - **password** *(optionel)* \
    Mot de passe de l'utilisateur
  - **host** *(optionel)* \
    Donne le host pour se connecter à la base postgres sql
  - **port** *(optionel)* \
    Port de la base de donnée
  - **verbose** *(default=False)* \
    Montre toute les requettes éffectué dans les scipts
- **data**
  - **source** \
    Est la source des fichier a inséré dans la base ansi que la 
    source des données lors de l'initialisation de la base
- **download**
  - **insert** *(default=False)* \
    Si a vrai insert les données dans la base apres le téléchargement.

#### Exemple

```ini
[postgresql]
host = localhost
dbname = bda
user = postgres
verbose = false

[data]
source = data_sources

[download]
insert = false
```

## Tests
Des tests sont disponibles dans le dossier [`tests/`](tests), 
ils utilise [Pytest](https://docs.pytest.org/en/6.2.x/). \
Pour ajouter [Pytest](https://docs.pytest.org/en/6.2.x/), 
dans l'enviroment il suffit de faire:
```shell
$ pipenv install --dev
```

Penser à initialiser et à configurer une base de test, 
avec le fichier [tests/database.ini](tests/database.ini).
Et de l'initialisé avec:
```shell
(env) $ python init.py -c tests/database.ini 
```

Pour lancer les tests ils suffit de faire
```shell
(env) $ pytest tests/
```

#### Template
Tout le projet utilise essentiellement SQL, on retrouve tout ces fichier sql
dans le dossier [src/templates](src/templates).

De meme pour les tests dans [tests/templates](tests/templates).

### Documents
- [Rapport préliminare](/Documents/rapport_préliminare_JeremyDAMOUR_DjamelALI.pdf)
- [Rapport final](/Documents/rapport_JeremyDAMOUR_DjamelALI.pdf)

### Authors
- Jéremy DAMOUR
- Djamel ALI

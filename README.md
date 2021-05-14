# BDA -- Covid-19 database

## Objectif

Ce projet se concentre sur les données hospitalières de la covid-19. Disponible sur le
site du [gouvernement](https://www.data.gouv.fr/fr/datasets/donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/#). \
Différents scripts python sont disponibles pour pouvoir utiliser facilement
ces données.

## Modélisation

![modélisation](/Documents/img/Diag_entite_association_projet_BDDA.jpg)

## Script

Les scripts utilisés sont en [Python 3.9](https://www.python.org/downloads/release/python-390/),
ils utilisent un environnement [Pipenv](https://pypi.org/project/pipenv/).
Aussi, ils utilise [psycopg2](https://www.psycopg.org/docs/)
pour gérer la base postgres plus facilement.

### [Pipenv](https://pypi.org/project/pipenv/)

Installer pipenv dans votre environnement python global avec la commande :
```shell
$ python -m pip install pipenv
```
(attention à utiliser python3.9)

Pour initialiser l'environnement :

```shell
$ pipenv install
```

Pour entrer dans l'environnement, tapez la commande :

```shell
$ pipenv shell
(env) $
```

Pour exécuter des commandes sans entrer dans l'environnement, utilisez la commande :

```shell
$ pipenv run ...
```

### Initialisation de la base

Pour initialiser la base de données avec le script [`init.py`](init.py).

```shell
(env) $ python init.py
```

### Téléchargement des données

Pour lancer le téléchargement des derniers fichiers, utiliser le
script [`dowload.py`](download.py).

```shell
(env) $ python download.py
```

### [Fichier Configuration](database.ini)

Les scripts précédents utilisent un fichier de
configuration [database.init](database.ini) par défaut.\
Vous pouvez en spécifier un avec l'argument `--config_file`.

#### Clef
- **postgres**
  - **dbname** \
    Nom de la base de données
  - **user** \
    Nom de l'utilisateur
  - **password** *(optionnel)* \
    Mot de passe de l'utilisateur
  - **host** *(optionnel)* \
    Donne le host pour se connecter à la base postgresql
  - **port** *(optionnel)* \
    Port de la base de données
  - **verbose** *(défaut=False)* \
    Montre toutes les requettes éffectuées dans les scipts
- **data**
  - **source** \
    Est la source des fichiers à insérer dans la base ainsi que la
    source des données lors de l'initialisation de la base
- **download**
  - **insert** *(default=False)* \
    Si (default=True) ça insert les données dans la base après le téléchargement.

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
ils utilisent [Pytest](https://docs.pytest.org/en/6.2.x/). \
Pour ajouter [Pytest](https://docs.pytest.org/en/6.2.x/),
dans l'environnement il faut entrer la commande :
```shell
$ pipenv install --dev
```

Pensez à initialiser et à configurer une base de test,
avec le fichier [tests/database.ini](tests/database.ini).
Et de l'initialiser avec:
```shell
(env) $ python init.py -c tests/database.ini
```

Pour lancer les tests ils suffit de taper
```shell
(env) $ pytest tests/
```

#### Template
Tout le projet utilise essentiellement SQL, on retrouve tous ces fichiers sql
dans le dossier [src/templates](src/templates).

De même pour les tests dans [tests/templates](tests/templates).

### Documents
- [Rapport préliminare](/Documents/rapport_préliminare_JeremyDAMOUR_DjamelALI.pdf)
- [Rapport final](/Documents/rapport_JeremyDAMOUR_DjamelALI.pdf)

### Authors
- Jéremy DAMOUR
- Djamel ALI

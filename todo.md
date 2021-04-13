# Général
* Mettre à jour le tableau des contraintes dans le rapport (par e.g. sexe n'est pas "UNIQUE")...

* Ajouter le nouveau lien (https://www.data.gouv.fr/en/datasets/regions-de-france/) vers liste regions-france.csv (car c'est plus simple que de les extraire de departements-france.csv mais je ne sais pas c'est le plus intelligent ^^), si c'est le cas, mettre à jour ça dans le rapport (le lien et les couleurs...).


* [pas très important] : Dans le tableaux des contraintes, l'attribut 'jour' dans les tables SexesDep, Incidence et AgesReg est normalement 'part of primary key' au lieu d'ecrire 'primary key' (à mon avis c'est mieux ... on en parlera). 

* Corriger dans le tableau des contraintes : dans AgesReg, description de clAge90 n'est pas bonne. (ecrire juste classes d'age réparties par intervalles de 10 ans (ou plus pour la dernière classe ([90 ans; x ans[) par e.g.).

from pathlib import Path
import requests
from bs4 import BeautifulSoup

URL = "https://www.data.gouv.fr/fr/datasets/" \
      "donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/" \
      "#community-resources"


def get_text(article):
    return article.h4.text


def get_url(article):
    return article.find("a", text="Télécharger").get("href")


def get_info(article):
    return get_text(article), get_url(article)


def get_infos():
    rep = requests.get(URL)
    page = BeautifulSoup(rep.content, features="html.parser")
    articles = page.find("div", class_="resources-list").find_all("article")
    it = map(get_info, articles)
    return \
        {
            "incid_reg": next(it),
            "sexe": next(it),
            "incid_dep": next(it),
            "age": next(it),
            "service": next(it)
        }


def save(folder: Path, name_file: str, url: str):
    rep = requests.get(url)
    if not folder.exists():
        folder.mkdir()
        print(f"create folder \"{folder}\"")

    path = str(folder / name_file)
    with open(path, 'w') as file:
        file.write(rep.text)
    print("create file:", path)
    return path


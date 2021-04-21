from bs4 import BeautifulSoup
from argparse import ArgumentParser
from pathlib import Path
import requests

URL = "https://www.data.gouv.fr/fr/datasets/" \
      "donnees-hospitalieres-relatives-a-lepidemie-de-covid-19/" \
      "#community-resources"


def parser_arg():
    parser = ArgumentParser()
    parser.add_argument("directory_output")
    args = parser.parse_args()
    return Path(args.directory_output)


def get_text(article):
    return article.h4.text


def get_url(article):
    return article.find("a", text="Télécharger").get("href")


def get_info(article):
    return get_text(article), get_url(article)


def save(folder, name_file, url):
    rep = requests.get(url)
    path = folder / name_file
    with open(path, 'w') as file:
        file.write(rep.text)
    return str(path)


def get_infos():
    rep = requests.get(URL)
    page = BeautifulSoup(rep.content, features="html.parser")
    articles = page.find("div", class_="resources-list").find_all("article")
    it = map(get_info, articles)
    return \
        {
            "incid": next(it),
            "sexe": next(it),
            "hospi_new": next(it),
            "age": next(it),
            "etabli": next(it)
        }


if __name__ == "__main__":
    dir_out = parser_arg()

    infos = get_infos()
    list_path = [save(dir_out, *info) for info in infos.values()]
    
    print(" ".join(list_path))

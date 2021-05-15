#!/usr/bin/env sh
rm -rf src/__pycache__/
rm -rf test/.pytests_cache/

zip projet_JeremyDAMOUR_DjamelALI.zip \
  -r data_sources \
  -r Documents \
  -r extension \
  -r src \
  -r tests\
  database.ini \
  download.py \
  init.py \
  Pipfile \
  rapport_JeremyDAMOUR_DjamelALI.pdf \
  README.md \

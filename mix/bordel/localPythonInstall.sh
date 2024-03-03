#!/bin/sh
python3 -m pip install --user pylint black poetry pipenv bandit mypy flake8 numpy scipy pandas matplotlib ipython ipykernel ipympl jupyterlab
ls "${HOME}/.local/bin"
#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
pip freeze --user | cut -d'=' -f1 | xargs pip install --upgrade --user -U

#!/bin/bash --login

set -e

conda activate autodocking
exec "$@"
#!/bin/bash -eu

PROJECT=/qulacs-osaka
cd $PROJECT

stubgen -p qulacs_osaka_core -o typings
pybind11-stubgen qulacs_osaka_core --no-setup-py --root-module-suffix="" --ignore-invalid=all --output-dir="./typings"

stubgen -p qulacs_osaka -o typings
pybind11-stubgen qulacs_osaka --no-setup-py --root-module-suffix="" --ignore-invalid=all --output-dir="./typings"

cd -

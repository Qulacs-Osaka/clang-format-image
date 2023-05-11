#!/bin/bash

PROJECT=/qulacs

# create .clang-format if not exists
[ -f $PROJECT/.clang-format ] || cp /.clang-format $PROJECT

cd $PROJECT
./script/format.sh

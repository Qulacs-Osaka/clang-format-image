#!/bin/bash

PROJECT=/qulacs

# create .clang-format if not exists
[ -f $PROJECT/.clang-format ] || cp /.clang-format $PROJECT

find $PROJECT/src $PROJECT/test $PROJECT/benchmark $PROJECT/python -regex '.*\.\(cu\|cuh\|cpp\|h\|hpp\)' -exec clang-format -style=file -i {} \;

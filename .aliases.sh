CONTAINER_NAME=ghcr.io/qulacs/qulacs-ubuntu-pyenv:latest
CONTAINER_NAME_FORMAT=ghcr.io/qulacs/qulacs-ubuntu-clang-format:latest

# Use single quote to avoid variable expansion.
RUN_CONTAINER='docker run --rm -it -v `pwd`:/qulacs -e USE_TEST=Yes'
RUN_CONTAINER_UNPRIVILEGED='docker run --rm -it -v `pwd`:/qulacs -e LOCAL_UID=`id -u $USER` -e LOCAL_GID=`id -g $USER` -e USE_TEST=Yes'

alias qulacs_run="$RUN_CONTAINER_UNPRIVILEGED $CONTAINER_NAME"
alias qulacs_test="$RUN_CONTAINER_UNPRIVILEGED $CONTAINER_NAME make test -C build -j"
alias qulacs_install="$RUN_CONTAINER $CONTAINER_NAME python setup.py bdist_wheel"
alias qulacs_generate_stub="$RUN_CONTAINER_UNPRIVILEGED $CONTAINER_NAME generate_stub"
alias qulacs_format="$RUN_CONTAINER_UNPRIVILEGED $CONTAINER_NAME_FORMAT"

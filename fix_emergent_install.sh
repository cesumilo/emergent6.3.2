#!/bin/sh

function print_err {
    (>&2 echo $1)
    exit 1
}

function check_err {
    if [ "$1" != "0" ]; then
        print_err $2
    fi
}

if [ -z $1 ]; then
    print_err "Usage:\n\t./fix_emergent_install.sh [bash/zsh/whatever]rc"
fi

BASHRC=$1
FIX_INSTALL_DIR=~/.bin

mkdir -p $FIX_INSTALL_DIR/emergent6.3.2
check_err "Impossible to create the fix installation directories."

echo "export PATH=$FIX_INSTALL_DIR:$PATH" >> $BASHRC
check_err "Impossible to add the fix installation path in the PATH environment variable."

mv /usr/local/bin/emergent $FIX_INSTALL_DIR/emergent6.3.2
check_err "Impossible to move the emergent binary file in the fix installation directory."

cp -r /usr/local/Cellar/qt@4/4.8.7_2/Frameworks/* .
check_err "Impossible to copy Qt4 frameworks in the fix installation directory."

cp -r /usr/local/Cellar/qt-webkit@2.3/2.3.4_1/lib/QtWebKit.framework .
check_err "Impossible to copy Qt4 WebKit frameworks in the fix installation directory."

echo "Fix applied. Enjoy!"
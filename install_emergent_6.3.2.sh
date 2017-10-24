#!/bin/sh

TMP_INSTALL_DIR=/tmp/emergent_install
DMG_URL=ftp://grey.colorado.edu/pub/emergent/older/emergent-6.3.2-6447-mac64.dmg
DMG_NAME=emergent-6.3.2-6447-mac64.dmg
VOLUME_DIR=/Volumes/emergent-6.3.2-mac

function check_err {
    if [ "$1" != 0 ]; then
        (>&2 echo $2)
        exit 1
    fi
}

function mountDMG {
  # Argument should be the name of the DMG.
  # Outputs the mount directory.

  # Note: there are tabs in the line below!  For some dumb reason the
  # output of hdiutil is a mix of tabs and spaces to separate columns --
  # not very friendly to scripts!
  hdiutil attach "$1" | sed -n 's/^\/dev.*[     ]Apple_HFS[     ]*//p'
}

function unmountDMG {
  # Argument should be the directory the DMG was mounted to.
  hdiutil detach "$1"
}

function openPKGinDMG {
  # Argument should be the name of the DMG.
  # finds the package file, opens it

  DMG_MNT="`mountDMG $1`"
  echo "mounted: $2"
  DMG_PKG="`ls -1rtd \"$2\"/*pkg | tail -1`"
  echo "package: $DMG_PKG"
  open "${DMG_PKG}"
}

mkdir -p $TMP_INSTALL_DIR
check_err $? "Error: Impossible to create temporary installation directory."

cd $TMP_INSTALL_DIR
check_err $? "Error: Impossible to cd in the temporary installation directory."

wget $DMG_URL
check_err $? "Error: Impossible to download the dmg package from ftp."

openPKGinDMG $DMG_NAME $VOLUME_DIR
check_err $? "Error: Impossible to open the package to install emergent."

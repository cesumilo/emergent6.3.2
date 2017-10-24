#!/bin/sh

TMP_INSTALL_DIR=/tmp/emergent_install
DMG_URL=ftp://grey.colorado.edu/pub/emergent/older/emergent_install_mac_deps.dmg
DMG_NAME=emergent_install_mac_deps.dmg
VOLUME_DIR=/Volumes/emergent_install_mac_deps

function check_err {
    if [ "$1" != "0" ]; then
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

function openSHinDMG {
  # Argument should be the name of the DMG.
  # finds the package file, opens it

  DMG_MNT="`mountDMG $1`"
  echo "mounted: $2"
  DMG_SH="`ls -1rtd \"$2\"/*sh | tail -1`"
  echo "script: $DMG_SH"
  /bin/sh "${DMG_SH}"
}

echo "Install pre-dependencies"
brew install pkg-config cmake subversion mercurial libsndfile gsl ode

echo "Install Qt4 and Qt4 WebKit..."
brew tap cartr/qt4
brew tap-pin cartr/qt4
brew install qt@4
brew install qt-webkit@2.3

echo "Install emergent dependencies..."
mkdir -p $TMP_INSTALL_DIR
check_err $? "Error: Impossible to create temporary installation directory."

cd $TMP_INSTALL_DIR
check_err $? "Error: Impossible to cd in the temporary installation directory."

wget $DMG_URL
check_err $? "Error: Impossible to download the dmg package from ftp."

openSHinDMG $DMG_NAME $VOLUME_DIR
check_err $? "Error: Impossible to open the sh script to install emergent dependencies."

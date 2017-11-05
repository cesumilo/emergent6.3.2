# emergent6.3.2
Installation script for MacOS Sierra 10.12.6 to install emergent v6.3.2

## Motivation
This script has been made to help University of Kent students installing emergent version 6.3.2 on MacOS in order to practice Cognitive Neural Network (CO836/636) classes at home.

## Dependencies
- [brew](https://brew.sh/)
- [wget](http://brewformulas.org/Wget)
- [ftp](http://www.techradar.com/how-to/software/operating-systems/how-to-use-ftp-through-the-command-line-in-mac-os-x-1305664)

## 0. Open a terminal
I hope your are all familiar with your terminal. If it's not the case, ask to a computer science student to help you! ;)

## 1. Install dependencies
Run the following script to retrieve the right dependencies.
```
./install_emergent_6.3.2_deps.sh
```
Several packages will be launched and asking you to install it. Follow their instructions. Since you finished all the installations, install emergent.

## 2. Install emergent
Run the following command line and follow the instructions to install emergent 6.3.2.
```
./install_emergent_6.3.2.sh
```

## 3. Install fix
It will fix and add the binary to the PATH environment variable. If you're not familiar with your terminal and you want to find out what is the `*rc` file: [click here](http://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/)
```
./fix_emergent_install.sh [bash/zsh/whatever]rc_filepath
```

## 4. Clean installation
```
./clean_install.sh
```

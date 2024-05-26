#!/bin/bash

#add env variables to .bashrc and current session
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC
echo "export DEVKITPRO=/opt/devkitpro" | tee -a ~/.bashrc
echo "export DEVKITARM=/opt/devkitpro/devkitARM" | tee -a ~/.bashrc
echo "export DEVKITPPC=/opt/devkitpro/devkitPPC" | tee -a ~/.bashrc


#download and install
curl -L https://gitlab.archlinux.org/pacman/pacman/-/releases/v6.1.0/downloads/pacman-6.1.0.tar.xz | tar xvJ
cd pacman-6.1.0
meson setup build
cd build
meson compile
meson install
cd ../..
rm -rf pacman-6.1.0

#initialize pacman
pacman-key --init

sudo pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0

sudo pacman -U --noconfirm https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.xz

#add the repos for devkitpro
echo "[dkp-libs]" | sudo tee -a /etc/pacman.conf
echo "Server = https://pkg.devkitpro.org/packages" | sudo tee -a /etc/pacman.conf
echo "[dkp-linux]" | sudo tee -a /etc/pacman.conf
echo "Server = https://pkg.devkitpro.org/packages/linux/\$arch/" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu --noconfirm


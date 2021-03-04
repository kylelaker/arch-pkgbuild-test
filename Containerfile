FROM docker.io/archlinux:base-devel

ARG PKGBUILD=./PKGBUILD

RUN pacman -Syu --noconfirm git \
    && useradd -Um builduser \
    && echo "builduser ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers \
    && mkdir /home/builduser/pkg \
    && chown -R builduser:builduser /home/builduser

USER builduser

WORKDIR /home/builduser

ADD --chown=builduser:builduser $PKGBUILD pkg/PKGBUILD

RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -si --noconfirm \
    && cd ~/pkg \
    && cat ./PKGBUILD \
    && source ./PKGBUILD \
    && yay -Syu --noconfirm ${depends[@]} ${makedepends[@]} \
    && makepkg -si --noconfirm

ENTRYPOINT /bin/bash

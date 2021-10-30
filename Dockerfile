FROM agners/archlinuxarm
ARG USER=alarm
WORKDIR /
USER root
RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm base-devel 
RUN pacman -S --noconfirm go git
RUN echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -mG root $USER
USER ${USER}
WORKDIR /home/${USER}
RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -Si \
    && makepkg -i --noconfirm 
RUN yay -S --noconfirm qemu-user-static-bin 
RUN sudo rm -rf /home/alarm
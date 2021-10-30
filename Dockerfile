FROM agners/archlinuxarm
ARG USER=alarm
WORKDIR /
USER root
RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm base-devel 
RUN pacman -S --noconfirm go git
RUN echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN groupadd users
RUN groupadd -r $USER
RUN useradd -m -g ${USER} $USER
RUN usermod -aG root $USER
USER ${USER}
RUN chown -R $USER:$USER /home/$USER
WORKDIR /home/${USER}
RUN git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -Si \
    && makepkg -i --noconfirm 
RUN yay -S --noconfirm qemu-user-static-bin
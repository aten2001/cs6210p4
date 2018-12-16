FROM archlinux/base:latest
MAINTAINER Gaurav Juvekar <gauravjuvekar@gmail.com>

COPY mirrorlist /etc/pacman.d/mirrorlist
RUN pacman --noconfirm -Sy base base-devel
RUN useradd builder -m && passwd -d builder && printf 'builder ALL=(ALL) ALL\n' | tee -a /etc/sudoers
COPY yay.tar.gz /tmp
RUN sudo -u builder tar -C /tmp -xf /tmp/yay.tar.gz
RUN cd /tmp/yay && sudo -u builder makepkg -si --noconfirm
RUN sudo -u builder yay --noconfirm -Sy grpc


COPY wholerepo.zip /root/
RUN pacman --noconfirm -Sy unzip
RUN cd /root/ && unzip wholerepo.zip
RUN cd /root/src && make && cd /root/test && make

FROM lscr.io/linuxserver/webtop:arch-kde

#Shell Config
RUN pacman -Syu zsh git curl fastfetch zoxide unzip jq --noconfirm --needed
RUN usermod -s /bin/zsh abc
RUN cd /tmp && sudo -u abc bash -c 'git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && yes | makepkg -si && cd .. && rm -rf paru-bin' && chown -R abc /config

#Programms
RUN sudo -u abc paru --noconfirm -S brave-bin nano visual-studio-code-bin

RUN pacman --noconfirm --needed -S kwin-x11 plasma-x11-session htop btop bash-completion xdg-utils iproute2 xdg-desktop-portal-kde 

# Remove unwanted Packages
RUN pacman --noconfirm -Rns chromium

#Multilib
RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Syu --noconfirm

ENV LC_ALL=de_DE.UTF-8
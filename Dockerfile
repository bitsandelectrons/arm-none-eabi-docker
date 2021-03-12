FROM archlinux

RUN echo "keyserver hkp://keyserver.ubuntu.com" >> /etc/pacman.d/gnupg/gpg.conf && \
        pacman -Sy --noconfirm && \
        pacman -S --noconfirm archlinux-keyring && \
        pacman -Suy --noconfirm && \
        pacman -S --noconfirm --needed \
        arm-none-eabi-gcc \
        arm-none-eabi-gdb \
        arm-none-eabi-newlib \
        arm-none-eabi-binutils \
        git \
        base-devel \
        jre-openjdk-headless \
        python \
        zip \
        && rm -rf /var/cache/pacman

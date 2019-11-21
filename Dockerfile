FROM archlinux

RUN pacman -Suy --noconfirm && pacman -S --noconfirm --needed \
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

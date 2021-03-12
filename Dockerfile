FROM archlinux

# From https://github.com/qutebrowser/qutebrowser/commit/478e4de7bd1f26bebdcdc166d5369b2b5142c3e2#diff-f5ac8dbaf3d87d762d99e75ab1fd15d13779d8c4dbc2c0504ebb64eaaf2783ee
# https://github.com/lxqt/lxqt-panel/commit/63026a26159358405821a03659cd7ddd390f3819#diff-120973fab988ae726a5656d291809dc02b9c40e3125d14b0cd4412e1ced8445a
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
        curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
        bsdtar -C / -xvf "$patched_glibc"

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

FROM debian:bookworm

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
	build-essential \
	autoconf \
	automake \
	bison \
	findutils \
	flex \
	gawk \
	gettext \
	grep \
	groff \
	gzip \
	libtool \
	m4 \
	pkgconf \
	sed \
	texinfo \
	which \
	cmake \
        gdb-multiarch \
        git \
        default-jre-headless \
        python3 \
        zip \
	clang-16 \
	libclang-16-dev \
	; \
    rm -rf /var/lib/apt/lists/*;

ENV PATH=/opt/arm-gnu-toolchain/bin:$PATH

RUN toolchainVersion=13.2.rel1; \
    set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
	wget \
	; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "${dpkgArch##*-}" in \
        amd64) hostArch='x86_64'; toolchainSha256='7fe7b8548258f079d6ce9be9144d2a10bd2bf93b551dafbf20fe7f2e44e014b8' ;; \
        arm64) hostArch='aarch64'; toolchainSha256='8fd8b4a0a8d44ab2e195ccfbeef42223dfb3ede29d80f14dcf2183c34b8d199a' ;; \
        *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
    esac; \
    url="https://developer.arm.com/-/media/Files/downloads/gnu/${toolchainVersion}/binrel/arm-gnu-toolchain-${toolchainVersion}-${hostArch}-arm-none-eabi.tar.xz"; \
    wget "$url"; \
    echo "${toolchainSha256} *$(echo arm-gnu-toolchain-*)" | sha256sum -c -; \
    tar xfC arm-gnu-toolchain* opt; \
    (cd opt; ln -s arm-gnu-toolchain-* arm-gnu-toolchain); \
    rm arm-gnu-toolchain*tar*; \
    apt-get remove -y --auto-remove \
        wget \
        ; \
    rm -rf /var/lib/apt/lists/*;

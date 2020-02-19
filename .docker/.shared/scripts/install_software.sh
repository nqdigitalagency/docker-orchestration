#!/bin/sh

apt-get update -yqq && apt-get install -yqq \
    build-essential \
    apt-transport-https \
    ca-certificates \
    iproute2 \
    curl \
    cmake \
    dnsutils \
    gdb \
    gnupg \
    git \
    htop \
    openssl \
    iputils-ping \
    ltrace \
    libevent-dev \
    make \
    libfcgi0ldbl \
    net-tools \
    procps \
    strace \
    sudo \
    sysstat \
    unzip \
    vim \
    wget \
    libssl-dev \
    lsb-release \
    zlib1g-dev \
;

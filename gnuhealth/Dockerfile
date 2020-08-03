FROM debian:10.1-slim

LABEL MAINTAINER=luengwattanapong.rom@gmail.com

ENV GNUHEALTH_VERSION=3.6.4
ARG GNUHEALTH_INSTALLER_VERSION=latest
ARG GNUHEALTH_URL="https://ftp.gnu.org/gnu/health/gnuhealth-${GNUHEALTH_VERSION}.tar.gz"
ARG GNUHEALTH_INSTALLER_URL="https://ftp.gnu.org/gnu/health/gnuhealth-setup-${GNUHEALTH_INSTALLER_VERSION}.tar.gz"
ARG DEBIAN_FRONTEND=noninteractive

# Prepare system
USER root

RUN mkdir -p /usr/share/man/man1 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        default-jre-headless \
        patch \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        unoconv \
        # uwsgi-plugin-python3 \
        libreoffice-common \
        libreoffice-java-common \
        vim \
        wget \
    && curl -sL https://deb.nodesource.com/setup_12.x | /bin/bash - \
    && apt-get install -y --no-install-recommends \
        git \
        nodejs \
    && npm install -g bower grunt-cli \
    && useradd -d /gnuhealth  -m -r -s /bin/bash gnuhealth \
    && rm -rf /var/lib/apt/lists/*

# Install GNUHealth
USER gnuhealth

ARG PATH="${PATH}:/gnuhealth/.local/bin"

RUN cd /gnuhealth \
    && wget ${GNUHEALTH_URL} \
    && tar -xvf gnuhealth-${GNUHEALTH_VERSION}.tar.gz \
    && cd gnuhealth-${GNUHEALTH_VERSION} \
    && wget -qO- ${GNUHEALTH_INSTALLER_URL} | tar -xzvf - \
    && /bin/bash ./gnuhealth-setup install \
    && cd /gnuhealth \
    && mkdir tryton-sao \
    && cd tryton-sao \
    && git clone https://github.com/tryton/sao.git . \
    && git checkout 5.0 \
    && npm install --production \
    && bower install \
    && grunt

# install s6-overlay
USER root

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.0.0.1/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C /

# Cleanup
USER root

RUN apt-get autoremove --purge -y \
        git \
        nodejs

COPY ./root /

VOLUME [ "/gnuhealth/attach", "/gnuhealth/log" ]

EXPOSE  8000

ENTRYPOINT ["/init"]

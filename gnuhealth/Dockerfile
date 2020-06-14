FROM debian:10

LABEL MAINTAINER=luengwattanapong.rom@gmail.com

ENV GNUHEALTH_VERSION=3.6.4
ENV GNUHEALTH_SETUP_VERSION=3.6.3
ENV TINI_VERSION=v0.19.0
ENV SAO_COMMIT_SHA=165366808c52c87e1f6a5231beb6e018a2546f9d

ARG DEBIAN_FRONTEND=noninteractive
ARG TERM=xterm

ENV PATH="$PATH:/server/.local/bin"

# Add tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# install dependencies
WORKDIR /server

RUN apt-get update \
    && apt-get install --no-install-recommends -yq \
        build-essential \
        ca-certificates \
        curl \
        git \
        gnupg \
        libpcre3 \
        libpcre3-dev \
        lsb-release \
        patch \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        sudo \
        vim \
        wget \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get update \
    && apt-get install --no-install-recommends -yq \
        nodejs \
    && npm install -g grunt-cli \
    && useradd -d /server -s /bin/bash gnuhealth \
    && chown -R gnuhealth /server \
    && python3 -m pip install uwsgi -I --no-cache-dir

# install GNU Health
USER gnuhealth

RUN wget https://ftp.gnu.org/gnu/health/gnuhealth-${GNUHEALTH_VERSION}.tar.gz \
    && tar xvf  gnuhealth-${GNUHEALTH_VERSION}.tar.gz --directory ./ \
    && cd gnuhealth-${GNUHEALTH_VERSION} \
    && wget -qO- https://ftp.gnu.org/gnu/health/gnuhealth-setup-${GNUHEALTH_SETUP_VERSION}.tar.gz | tar -xzvf - \
    && /bin/bash ./gnuhealth-setup install

# install sao
RUN mkdir -p /server/sao \
    && cd /server/sao \
    && git clone -n https://github.com/tryton/sao.git . \
    && git checkout ${SAO_COMMIT_SHA} \
    && npm install --production \
    && grunt

# clean up
USER root

RUN apt-get clean autoclean \
    && apt-get autoremove --yes \
        build-essential \
        ca-certificates \
        curl \
        git \
        gnupg \
        patch \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /server/gnuhealth-${GNUHEALTH_VERSION}*

ADD root/ /

EXPOSE 8080
VOLUME [ "/server/attach", "/server/gnuhealth/logs", "/server/gnuhealth/tryton/server/config" ]

ENTRYPOINT ["/tini", "--"]
CMD [ "/bin/bash", "/server/prestart.sh" ]

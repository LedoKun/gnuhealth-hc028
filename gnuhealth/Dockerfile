FROM opensuse/leap:15.2

LABEL MAINTAINER=luengwattanapong.rom@gmail.com
USER root

# install tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# install gnuhealth
RUN zypper --non-interactive in --no-recommends \
        git \
        gnuhealth \
        nodejs12 \
        npm12 \
    && npm install -g bower grunt-cli \
    && mkdir -p /var/lib/trytond/www \
    && cd /var/lib/trytond/www \
    && git clone https://github.com/tryton/sao.git . \
    && git checkout 5.0 \
    && npm install --production \
    && bower install --allow-root \
    && grunt
COPY ./root/etc /etc/
VOLUME ["/var/lib/tryton", "/var/log/tryton"]

EXPOSE  8000

ENTRYPOINT ["/tini", "--"]

CMD ["/usr/bin/trytond", "--config=/etc/tryton/trytond.conf", "--pidfile=/tmp/trytond.pid", "--logconf=/etc/tryton/trytond_log.conf"]

USER tryton

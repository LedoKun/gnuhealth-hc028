FROM tryton/tryton:5.0-office

LABEL MAINTAINER=luengwattanapong.rom@gmail.com

ENV GNUHEALTH_VERSION=3.6

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        build-essential \
        gnupg2 \
        libldap2-dev \
        libpython3-dev \
        libsasl2-dev \
        libssl-dev \
        python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/bin/pip3 install --no-cache-dir \
        "Pillow" \
        "bcrypt" \
        "beren" \
        "caldav" \
        "configparser" \
        "lxml" \
        "matplotlib" \
        "numpy" \
        "passlib" \
        "pendulum" \
        "polib" \
        "psycopg2-binary" \
        "python-barcode" \
        "python-dateutil" \
        "python-gnupg" \
        "python-ldap" \
        "python-magic" \
        "python-sql" \
        "python-stdnum" \
        "pytz" \
        "pywebdav3-gnuhealth" \
        "qrcode" \
        "relatorio" \
        "setuptools" \
        "simpleeval" \
        "six" \
        "unoconv" \
        "vobject==0.9.5" \
        "werkzeug<1.0" \
        "wrapt" \
    && /usr/bin/pip3 install --no-cache-dir \
        "gnuhealth>=${GNUHEALTH_VERSION}" \
        "gnuhealth-archives>=${GNUHEALTH_VERSION}" \
        "gnuhealth-caldav>=${GNUHEALTH_VERSION}" \
        "gnuhealth-calendar>=${GNUHEALTH_VERSION}" \
        "gnuhealth-contact-tracing>=${GNUHEALTH_VERSION}" \
        "gnuhealth-crypto>=${GNUHEALTH_VERSION}" \
        "gnuhealth-crypto-lab>=${GNUHEALTH_VERSION}" \
        "gnuhealth-disability>=${GNUHEALTH_VERSION}" \
        "gnuhealth-ems>=${GNUHEALTH_VERSION}" \
        "gnuhealth-federation>=${GNUHEALTH_VERSION}" \
        "gnuhealth-genetics>=${GNUHEALTH_VERSION}" \
        "gnuhealth-genetics-uniprot>=${GNUHEALTH_VERSION}" \
        "gnuhealth-gyneco>=${GNUHEALTH_VERSION}" \
        "gnuhealth-history>=${GNUHEALTH_VERSION}" \
        "gnuhealth-icd10>=${GNUHEALTH_VERSION}" \
        "gnuhealth-icd10pcs>=${GNUHEALTH_VERSION}" \
        "gnuhealth-icd9procs>=${GNUHEALTH_VERSION}" \
        "gnuhealth-icpm>=${GNUHEALTH_VERSION}" \
        "gnuhealth-icu>=${GNUHEALTH_VERSION}" \
        "gnuhealth-imaging>=${GNUHEALTH_VERSION}" \
        "gnuhealth-inpatient>=${GNUHEALTH_VERSION}" \
        "gnuhealth-inpatient-calendar>=${GNUHEALTH_VERSION}" \
        "gnuhealth-insurance>=${GNUHEALTH_VERSION}" \
        "gnuhealth-iss>=${GNUHEALTH_VERSION}" \
        "gnuhealth-lab>=${GNUHEALTH_VERSION}" \
        "gnuhealth-lifestyle>=${GNUHEALTH_VERSION}" \
        "gnuhealth-mdg6>=${GNUHEALTH_VERSION}" \
        "gnuhealth-ntd>=${GNUHEALTH_VERSION}" \
        "gnuhealth-ntd-chagas>=${GNUHEALTH_VERSION}" \
        "gnuhealth-ntd-dengue>=${GNUHEALTH_VERSION}" \
        "gnuhealth-nursing>=${GNUHEALTH_VERSION}" \
        "gnuhealth-ophthalmology>=${GNUHEALTH_VERSION}" \
        "gnuhealth-orthanc>=${GNUHEALTH_VERSION}" \
        "gnuhealth-pediatrics>=${GNUHEALTH_VERSION}" \
        "gnuhealth-pediatrics-growth-charts>=${GNUHEALTH_VERSION}" \
        "gnuhealth-pediatrics-growth-charts-who>=${GNUHEALTH_VERSION}" \
        "gnuhealth-profile>=${GNUHEALTH_VERSION}" \
        "gnuhealth-qrcodes>=${GNUHEALTH_VERSION}" \
        "gnuhealth-reporting>=${GNUHEALTH_VERSION}" \
        "gnuhealth-services>=${GNUHEALTH_VERSION}" \
        "gnuhealth-services-lab>=${GNUHEALTH_VERSION}" \
        "gnuhealth-socioeconomics>=${GNUHEALTH_VERSION}" \
        "gnuhealth-stock>=${GNUHEALTH_VERSION}" \
        "gnuhealth-surgery>=${GNUHEALTH_VERSION}" \
        "gnuhealth-webdav3-server>=${GNUHEALTH_VERSION}" \
        "gnuhealth-who-essential-medicines>=${GNUHEALTH_VERSION}" \
        && apt-get autoremove --yes \
            build-essential \
            libldap2-dev \
            libpython3-dev \
            libsasl2-dev \
            libssl-dev \
            python3-dev

COPY ./root/etc /etc/

ENV TRYTOND_CONFIG="/etc/trytond.conf"
ENV TRYTOND_LOGGING_CONFIG="/etc/gnuhealth_log.conf"

VOLUME ["/var/lib/trytond/db"]

USER trytond

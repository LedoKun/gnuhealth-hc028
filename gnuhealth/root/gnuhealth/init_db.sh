#!/bin/bash

set -e

export TEMP_PASSWORD=$(sed "s/[^a-zA-Z0-9]//g" <<<$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%*()-+' | fold -w 32 | head -n 1))
export TRYTOND=$(ls -1d /gnuhealth/gnuhealth/tryton/server/trytond-* | egrep -o "trytond-[0-9\.]+.[0-9\.]+.[0-9\.]+" | sort -V | tail -1)
export TRYTOND_ADMIN_PATH="/gnuhealth/gnuhealth/tryton/server/${TRYTOND}/bin/trytond-admin"
export TEMP_INPUT="test@test.test\n${TEMP_PASSWORD}\n${TEMP_PASSWORD}"

echo "Postgres is ready, running the migrations..."
echo "Temporary password for admin user: ${TEMP_PASSWORD}"
echo "Please change the admin password!"
echo "Initializing GNUHealth database..."

printf ${TEMP_INPUT} | /usr/bin/python3 ${TRYTOND_ADMIN_PATH} \
    --config /gnuhealth/gnuhealth/tryton/server/config/trytond.conf \
    --logconf /gnuhealth/gnuhealth/tryton/server/config/trytond_log.conf \
    --database gnuhealth \
    --all

echo "Enable GNUHealth modules..."

/usr/bin/python3 ${TRYTOND_ADMIN_PATH} \
    --config /gnuhealth/gnuhealth/tryton/server/config/trytond.conf \
    --logconf /gnuhealth/gnuhealth/tryton/server/config/trytond_log.conf \
    --database gnuhealth \
    -u health_profile \
    -u health_archives \
    -u health_calendar \
    -u health_contact_tracing \
    -u health_crypto \
    -u health_disability \
    -u health_ems \
    -u health_genetics \
    -u health_genetics_uniprot \
    -u health_gyneco \
    -u health_history \
    -u health_icd10 \
    -u health_icd10pcs \
    -u health_icd9procs \
    -u health_icpm \
    -u health_imaging \
    -u health_insurance \
    -u health_iss \
    -u health_lab \
    -u health_lifestyle \
    -u health_mdg6 \
    -u health_ntd \
    -u health_ntd_chagas \
    -u health_ntd_dengue \
    -u health_ophthalmology \
    -u health_orthanc \
    -u health_pediatrics \
    -u health_pediatrics_growth_charts \
    -u health_pediatrics_growth_charts_who \
    -u health_qrcodes \
    -u health_reporting \
    -u health_services \
    -u health_services_lab \
    -u health_socioeconomics \
    -u health_who_essential_medicines \
    --activate-dependencies

echo "Done..."

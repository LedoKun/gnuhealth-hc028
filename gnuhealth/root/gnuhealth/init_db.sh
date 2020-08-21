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
    --activate-dependencies

echo "Done..."

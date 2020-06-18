#!/bin/bash

set -e

: ${PYTHONOPTIMIZE:=1}
: ${CONTAINER_ROLE:='server'}
: ${DB_NAME:=${POSTGRES_DB_NAME:='postgres'}}

export PYTHONOPTIMIZE

case $CONTAINER_ROLE in
    server)
        echo "Starting GNU Health Server..."
        set -- uwsgi --ini /etc/uwsgi.conf --thunder-lock "$@"
        ;;
    worker)
        echo "Starting GNU Health Worker Service..."
        set -- /usr/local/bin/trytond-worker -d $DB_NAME -c $TRYTOND_CONFIG --logconf $TRYTOND_LOGGING_CONFIG "$@"
        ;;
    cron)
        echo "Starting GNU Health Cron Service..."

        set -- /usr/local/bin/trytond-cron -d $DB_NAME -c $TRYTOND_CONFIG --logconf $TRYTOND_LOGGING_CONFIG "$@"
        ;;
    *)
        echo "Unknown role... sleeping zzzZzzz...ZZzzzzz..."
        set -- sleep 10000 "$@"
        ;;
esac

exec "$@"

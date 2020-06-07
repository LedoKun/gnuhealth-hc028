#!/bin/bash
set -e

echo "Correcting files ownership..."
chown -R gnuhealth: /server/attach
chown -R gnuhealth: /server/gnuhealth/log

echo "Starting Tryton server..."
su - gnuhealth -c "/bin/bash /server/start.sh"

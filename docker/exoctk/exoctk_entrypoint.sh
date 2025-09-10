#!/bin/sh

until cd /exoctk/exoctk/exoctk
do
    echo "Waiting for server volume..."
done

# run flask
# flask --app exoctk_app run

python /exoctk/exoctk/exoctk/app_exoctk/app_exoctk.app

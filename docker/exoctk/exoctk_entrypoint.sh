#!/bin/sh

until cd /exoctk/exoctk/exoctk/exoctk_app
do
    echo "Waiting for server volume..."
done

# run flask
flask --app exoctk_app run

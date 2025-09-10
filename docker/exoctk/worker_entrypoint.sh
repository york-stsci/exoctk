#!/bin/sh

until cd /exoctk/exoctk/exoctk/exoctk_app
do
    echo "Waiting for server volume..."
done

# run a worker :)
celery -A app_exoctk worker --loglevel=info --concurrency 1 -E

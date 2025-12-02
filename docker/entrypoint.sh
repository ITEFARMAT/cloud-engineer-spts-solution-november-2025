#!/bin/sh
set -e

DEVELOPMENT="${DEVELOPMENT:-false}"

echo "DEVELOPMENT=${DEVELOPMENT}, PORT=${PORT}"

export PYTHONPATH=/app/src

if [ "$DEVELOPMENT" = "true" ]; then
    echo "Starting DEVELOPMENT server..."
    cd /app/src
    exec python entrypoints/asgi_dev.py 
else
    echo "Starting PRODUCTION server ..."
    cd /app/src
    exec uvicorn "entrypoints.asgi:app" 
fi

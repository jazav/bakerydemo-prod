#!/bin/sh
set -e
timer="5"

# build the correct database url for postgresql
#postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]
#export DATABASE_URL=postgres://$POSTGRES_USER:`cat $DBUSER_PASSWORD_FILE`@postgresql:$POSTGRES_PORT/$POSTGRES_DB

# Statement for secrets in yaml, for example
#swarm:
#  secrets:
#    - name: dbuser-password
#      value: changeme
#pass=$(cat $DBUSER_PASSWORD_FILE | grep -A1 'dbuser-password' | grep value: | sed -E 's/value://' | sed "s/ //g")
# Statement for secret in one string file
#pass=$(cat $DBUSER_PASSWORD_FILE)

DATABASE_URL=postgres://$POSTGRES_USER:$(cat $DBUSER_PASSWORD_FILE)@postgresql:$POSTGRES_PORT/$POSTGRES_DB
export DATABASE_URL

CACHE_URL=redis://default:$(cat $REDIS_PASSWORD_FILE)@redis:$REDIS_PORT_NUMBER
export CACHE_URL

until psql "$DATABASE_URL" -c '\l'; do
  echo >&2 " Postgres is unavailable - sleeping for $timer seconds"
  sleep $timer
done

echo >&2 " Postgres is up - continuing"

if [ "$1" = '/venv/bin/uwsgi' ]; then
  echo >&2 " Migration is starting"
  /venv/bin/python manage.py migrate --noinput
  # AZ Update elasticsearch indexes
  echo >&2 " Elasticsearch indexes are updating"
  /venv/bin/python manage.py update_index
fi

if [ "x$DJANGO_LOAD_INITIAL_DATA" = 'xon' ]; then
  echo >&2 " Loading initial data"
  /venv/bin/python manage.py load_initial_data
fi

exec "$@"

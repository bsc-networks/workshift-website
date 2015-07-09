#!/bin/bash -e

# An example script to run workshift website in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv. It uses a PostgreSQL database. The first time you have to create a database itself and account
# with permissions over it.
#
# You have to create production config files. See the list below which one are mounted as volumes into a container.
# To create them, copy them over from the repository and modify.

NAME='workshift'
DATA_ROOT='/srv'
WORKSHIFT_CONFIG="${DATA_ROOT}/${NAME}/config"
WORKSHIFT_DB_SETTINGS="${WORKSHIFT_CONFIG}/database.yml"
WORKSHIFT_ENVIRONMENT="${WORKSHIFT_CONFIG}/environments/production.rb"
WORKSHIFT_SECRET_TOKEN="${WORKSHIFT_CONFIG}/initializers/secret_token.rb"
WORKSHIFT_DEVISE="${WORKSHIFT_CONFIG}/initializers/devise.rb"

mkdir -p "${WORKSHIFT_CONFIG}"

# If you are running the PostgreSQL image for the first time with its data volume, you should configure the
# database. Exec into the Docker container and run the following example commands to create user "workshift"
# with database "workshfit", by default:
#
# docker exec -t -i pgsql /bin/bash
#
# createuser -h pgsql.server2.docker -PE -DRS -U postgres -W workshift
# createdb -h pgsql.server2.docker -U postgres -W -O workshift workshift

docker stop "${NAME}" || true
sleep 1
docker rm "${NAME}" || true
sleep 1
docker run --detach=true --restart=always --name "${NAME}" --hostname "${NAME}" --expose 3000 --volume /srv/var/hosts:/etc/hosts:ro --volume "${WORKSHIFT_DB_SETTINGS}:/app/config/database.yml" --volume "${WORKSHIFT_ENVIRONMENT}:/app/config/environments/production.rb" --volume "${WORKSHIFT_SECRET_TOKEN}:/app/config/initializers/secret_token.rb" --volume "${WORKSHIFT_DEVISE}:/app/config/initializers/devise.rb" bscnetworks/workshift-website rails server --port 3000 --binding 0.0.0.0 --environment production

# When running it for the first time, you have to create tables in the database, by default:
#
# docker exec -t -i workshift /bin/bash
#
# RAILS_ENV=production rake db:create
#
# Alternativelly, if you want to also seed the database with initial data and accounts, run:
#
# RAILS_ENV=production rake db:setup

# DATABASE INITIALIZATION DURING FIRST RUNTIME - BÁLINT TÓTH - 2024. 08. 19 #

# as root:

echo "dock_user ALL = NOPASSWD: /usr/sbin/postfix start" > /etc/sudoers.d/dock

# as db user

initdb -D /container-data/
echo "host all all 0.0.0.0/0 md5" >> /container-data/pg_hba.conf
echo "listen_addresses = '*'" >> /container-data/postgresql.conf

postgres -D /container-data &
createdb thesis

# psql

psql thesis
CREATE USER admin WITH LOGIN SUPERUSER PASSWORD 'asd';

# SOURCES:
#
# https://www.postgresql.org/docs/current/database-roles.html

# CUSTOM DOCKER IMAGE FOR THE THESIS APP - BÁLINT TÓTH - 2024. 08. 19 #

FROM debian:bookworm

ENV TZ="Europe/Budapest"

RUN \

groupadd -g 2000 -r dock_group && \
useradd -g 2000 -u 2000 -d /container-data/user_home -s /bin/bash -N dock_user && \

apt update && \
apt install -y wget tzdata git && \
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
dpkg -i packages-microsoft-prod.deb && \
rm packages-microsoft-prod.deb && \

apt update && \
apt upgrade && \
apt install -y dotnet-sdk-8.0

USER dock_user:dock_group

ENTRYPOINT ["/container-config/entrypoint.sh"]

# SOURCES:
#
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-debian
# https://hub.docker.com/_/debian/tags

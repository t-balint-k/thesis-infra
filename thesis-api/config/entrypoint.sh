#!/bin/sh

# ENTRYPOINT SCRIPT FOR THE THESIS APPLICATION - BÁLINT TÓTH - 2024. 08. 19 #

umask 027

trap 'kill -TERM $PID' TERM INT
#dotnet run --project /container-data/webservice/thesis_api.csproj &
#sshd
sleep infinity &
PID=$!
wait $PID

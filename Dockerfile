FROM i386/ubuntu:latest AS libmysqlclient
RUN apt-get update && apt-get install -y libmysqlclient20

FROM libmysqlclient AS liblua
RUN export DEBIAN_FRONTEND=noninteractive && \
    echo tzdata tzdata/Zones/Europe select London | debconf-set-selections && \
    echo tzdata tzdata/Zones/Etc select UTC | debconf-set-selections && \
    apt-get update && apt-get install -y liblua5.1

FROM liblua AS builder
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    libmysqlclient-dev \
    lua5.1 \
    mysql-client-5.7
COPY ./rtk /home/rtk
RUN cd /home/rtk && make all

# FROM libmysqlclient AS server
# COPY --from=builder /home/rtk /home/rtk
# COPY ./rtklua /home/rtklua

FROM liblua AS mapserver
COPY --from=builder /home/rtk /home/rtk
COPY ./rtklua /home/rtklua
COPY ./rtkmaps /home/rtkmaps

# FROM server AS login-server
# FROM server AS char-server
FROM mapserver AS map-server

# TODO: Implement cron job for automated database backups

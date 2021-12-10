FROM ubuntu:latest

RUN apt update && apt install curl -y && apt install build-essential -y

ENV APP_HOME=/opt/MojoCom

RUN mkdir $APP_HOME

COPY ./ "${APP_HOME}"

# Install Mojolicious
RUN curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious
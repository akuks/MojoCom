FROM ubuntu:latest

# Application Home
ENV APP_HOME=/opt/MojoCom

RUN apt update && apt install curl -y && apt install build-essential -y

# Install the Node
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && bash nodesource_setup.sh && \
    apt install nodejs -y

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install yarn -y


# Setting up the Mojolicious
# Install Mojolicious
RUN curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious

RUN mkdir $APP_HOME

COPY ./ "${APP_HOME}"
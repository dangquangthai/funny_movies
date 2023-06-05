FROM ruby:3.1.2

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        curl \
        git \
        libssl-dev \
        wget \
        libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# nvm environment variables
ENV NODE_VERSION 14.16.0

# Install nvm with node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install node and npm
RUN . ~/.nvm/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN mkdir /app
WORKDIR /app

COPY Gemfile* package.json yarn.lock /app/

RUN gem install bundler --version 2.3.21 && bundle install --jobs 4 --retry 3

COPY . /app

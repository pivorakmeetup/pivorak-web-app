FROM ruby:2.3.1
MAINTAINER Yuriy Pasichynskiy <yuriy.pasichynskiy@teamvoy.com>

ENV BUNDLER_VERSION 1.17.2
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y build-essential nodejs \
    cron nano vim

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /


ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.2/wait /wait

ENV GEM_HOME=/bundle
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_BIN=/bundle/bin
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH

COPY Gemfile Gemfile.lock ./ 

RUN gem update --system && gem install bundler:$BUNDLER_VERSION

RUN mkdir -p /app
WORKDIR /app

COPY . ./

RUN bundle check || bundle install

RUN cp config/database.yml.example config/database.yml

# Add docker-entrypoint
COPY ./docker-entrypoint.sh /

RUN chmod +x  /wait /docker-entrypoint.sh

ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION
ARG NODE_MAJOR

RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -
RUN apt-get update && apt-get install -y build-essential nodejs

ENV GEM_HOME=/bundle
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH

RUN gem update --system && gem install bundler:$BUNDLER_VERSION

RUN mkdir -p /app
WORKDIR /app

COPY . ./
RUN cp config/database.yml.example config/database.yml

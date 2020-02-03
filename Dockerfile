FROM ruby:2.3.8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN gem update --system
RUN bundle install --jobs=5 --retry=3

COPY . /usr/src/app

EXPOSE 3000

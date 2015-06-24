FROM ruby:2.2.2
MAINTAINER M. Lequeux--Gruninger <martin.lequeux.gruninger@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

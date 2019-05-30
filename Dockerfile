FROM ruby:2.4.1
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y nodejs mysql-client
RUN gem install rails -v '5.1.7'

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

LABEL maintainer="Sarah Tharwat <sarahtharwat7@gmail.com>"

CMD puma -C config/puma.rb
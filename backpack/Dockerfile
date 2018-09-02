FROM ruby:2.4.2-alpine3.4
RUN apk add --update && apk add build-base nodejs tzdata mariadb-dev file-dev
RUN npm install --save svg-captcha
RUN mkdir /smart_contracts
RUN addgroup -S app && adduser -S -g app app
#FROM kunalkashyap27/alpine_basic:firsttry
WORKDIR /smart_contracts
ADD Gemfile /smart_contracts/Gemfile
ADD Gemfile.lock /smart_contracts/Gemfile.lock
RUN bundle install
ADD . /smart_contracts
#ENV RAILS_ENV production
#RUN bundle exec rake assets:precompile
RUN chown -R app:app /smart_contracts
#USER app
EXPOSE 8000

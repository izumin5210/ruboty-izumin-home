FROM hypriot/rpi-ruby
MAINTAINER izumin5210 <masayuki@izumin.info>

RUN apt-get update \
    && apt-get -y --no-install-recommends install gcc make

ENV PROJECT /ruboty
RUN mkdir $PROJECT
WORKDIR $PROJECT

ADD Gemfile $PROJECT
ADD Gemfile.lock $PROJECT

RUN bundle install

ADD . $PROJECT

CMD ["ruboty", "--dotenv"]

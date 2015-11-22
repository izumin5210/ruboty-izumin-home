FROM hypriot/rpi-ruby
MAINTAINER izumin5210 <masayuki@izumin.info>

RUN apt-get update \
    && apt-get -y --no-install-recommends install gcc g++ make

RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

ENV PROJECT /ruboty
RUN mkdir $PROJECT
WORKDIR $PROJECT

ADD Gemfile $PROJECT
ADD Gemfile.lock $PROJECT

RUN bundle install

ADD . $PROJECT

CMD ["ruboty", "--dotenv"]

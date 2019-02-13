FROM ruby:2.5.1-stretch

# setup packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y install \
        bash \
        locales \
        tmux \
        vim \
        jq

# setup locales
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# setup bundler
ENV RUBYLIB /app/lib:$RUBYLIB
ENV PATH /app/bin:$PATH
WORKDIR /app
COPY Gemfile* *.gemspec /app/
COPY lib/zombie_battleground/api/version.rb /app/lib/zombie_battleground/api/version.rb
COPY bin/setup /app/bin/setup
RUN setup

# setup api
COPY . /app/

# entry point
CMD ["console"]

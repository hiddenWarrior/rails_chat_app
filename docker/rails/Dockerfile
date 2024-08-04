FROM ruby:3.0.0
RUN apt-get -y update && apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata  nodejs npm yarn && \
apt-get clean && rm -rf /var/lib/apt/list/* /usr/share/doc /usr/share/man
RUN gem install rails -v '~> 6.1.7.8'
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN ["bundle", "install"]
COPY ./docker/rails/entrypoint.sh /
entrypoint ["bash", "/entrypoint.sh"]
CMD ["rails", "server","-b", "0.0.0.0"]
# CMD ["sleep", "9999999"]

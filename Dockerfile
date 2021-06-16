FROM ruby:latest
MAINTAINER Debashis Nath <nath.deb006@gmail.com>
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ADD . /app/
RUN set -uex; \
    bundle install; \
    useradd -u 1000 -Um rubyapp; \
    mkdir -p /app/data; \
    chown -R rubyapp:rubyapp /app/data
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
USER rubyapp
CMD [ "ruby", "http_server.rb"]

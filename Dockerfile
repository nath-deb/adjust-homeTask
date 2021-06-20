FROM ruby:latest
MAINTAINER Debashis Nath <nath.deb006@gmail.com>
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ADD . /app/
RUN chmod 777 -R /app
RUN chmod +x /app/http_server.rb
RUN set -uex; \
    bundle install; \
    useradd -u 1001 rubyapp; \
   # mkdir -p /app/data; \
    chown -R rubyapp:rubyapp /app
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
USER root
EXPOSE 80
ENTRYPOINT ["ruby", "/app/http_server.rb"]

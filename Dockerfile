# === 1 ===
FROM phusion/passenger-ruby22
MAINTAINER Jeroen van Baarsen "jeroen@firmhouse.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# === 2 ===
# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# === 3 ====
# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx info
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf


# === 4 ===
# Prepare folders
RUN mkdir /home/app/webapp

# === 5 ===
# Run Bundle in a cache efficient way
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

# === 6 ===
# Add the rails app
ADD . /home/app/webapp

# Fix rights and write crontab
RUN cd /home/app/webapp ; chown -R app:app . ; whenever -u app -w

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

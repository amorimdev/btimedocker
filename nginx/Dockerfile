FROM debian:jessie

MAINTAINER Jhonatan Amorim <amorim.dev@gmail.com>

RUN apt-get update && apt-get install -y \
    nginx

COPY nginx.conf /etc/nginx/
COPY btimeapp.conf /etc/nginx/sites-available/
COPY btimeweb.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/btimeapp.conf /etc/nginx/sites-enabled/btimeapp
RUN ln -s /etc/nginx/sites-available/btimeweb.conf /etc/nginx/sites-enabled/btimeweb
RUN rm /etc/nginx/sites-enabled/default
RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80

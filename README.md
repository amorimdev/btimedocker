# Btime Docker

> Stack: PHP-FPM, Nginx, MySQL, ElasticSearch, Memcached, RabbitMQ and Redis. 

## What's inside

* [PHP-FPM](http://php-fpm.org/)
* [Nginx](http://nginx.org/)
* [MySQL](http://www.mysql.com/)
* [ElasticSearch](https://www.elastic.co/)
* [Memcached](http://memcached.org/)
* [RabbitMQ](https://www.rabbitmq.com/)
* [Redis](http://redis.io/)

## Requirements

* [Docker Engine](https://docs.docker.com/installation/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Machine](https://docs.docker.com/machine/) (Mac and Windows only)

## Running

First init project git submodule:
```sh
$ git submodule init && git submodule update
```

Now copy .env.dist to .env file:
```sh
$ cp .env.dist .env
```

Set up a Docker Machine and then run:

```sh
$ docker-compose up
```

## Application commands:

Project btimeapp:

```sh
$ docker-compose run php bash -c 'cd /var/www/btimeapp \
    && cp app/config/parameters.yml.dist app/config/parameters.yml \
    && composer install \
    && php app/console doctrine:migrations:migrate -n \
    && php app/console doctrine:cache:clear-query \
    && php app/console doctrine:cache:clear-metadata \
    && php app/console doctrine:cache:clear-result \
    && php app/console rabbitmq:setup-fabric \
    && php app/console assetic:dump \
    && chmod 777 -Rf app/cache app/logs web/js web/css web/tmp'
```

Project btimeweb:

```sh
$ docker-compose run php bash -c 'cd /var/www/btimeweb \
    && cp app/config/parameters.yml.dist app/config/parameters.yml \
    && composer install \
    && php bin/console assetic:dump \
    && chmod 777 -Rf var/cache var/logs var/sessions web/js web/css'
```

## Linux
Edit file /etc/hosts and add line:
```sh
127.0.0.1       local-app.btime.com.br local.btime.com.br
```

## Mac and Windows
Edit file and add line:
- Mac: /etc/hosts
- Windows: C:\Windows\System32\drivers\etc\hosts
```sh
192.168.99.100       local-app.btime.com.br local.btime.com.br
```
(p.s) on composer install error, please unzip [btimeapp.tar.gz](https://s3-sa-east-1.amazonaws.com/btime/btimeapp.tar.gz) and [btimeweb.tar.gz](https://s3-sa-east-1.amazonaws.com/btime/btimeweb.tar.gz) files in projects directories

## License

Copyright &copy; 2017 [Btime Soluções](http://github.com/Btime). Licensed under the terms of the [MIT license](LICENSE.md).

## ubuntu-apache2-php7-with-cron example

run sinatra app and local redis-server.

```
$ docker build -t alpine-nginx-ruby:latest .
```

Run like under the alm-agent.

```
$ docker run --rm \
  -v `pwd`/code:/srv/code \
  -v `pwd`/code/mobingi-init.sh:/tmp/init/init.sh \
  -e MYENV=TESTSERVER \
  -p 8080:9292 alpine-nginx-ruby:latest
```


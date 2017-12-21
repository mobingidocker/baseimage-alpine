## ubuntu-apache2-php7-with-cron example

run php server under Apache httpd + mod_php and crond.

```
$ docker build -t ubuntu-apache2-php7-with-cron:latest .
```

Run like under the alm-agent.

```
$ docker run --rm \
  -v `pwd`/code:/var/www/html/ \
  -v `pwd`/code/mobingi-init.sh:/tmp/init/init.sh \
  -p 8080:80 ubuntu-apache2-php7-with-cron:latest
```


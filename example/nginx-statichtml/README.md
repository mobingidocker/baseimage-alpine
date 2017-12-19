## nginx-statichtml example


```
$ docker build -t nginx-statichtml:latest .
```

Run like under the alm-agent.

```
$ docker run --rm \
  -v `pwd`/code:/var/lib/nginx/html/ \
  -v `pwd`/mobingi-init.sh:/tmp/init/init.sh \
  -p 8080:80 nginx-statichtml:latest
```

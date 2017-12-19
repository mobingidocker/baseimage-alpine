FROM mobingi/baseimage:alpine-3.7
LABEL com.mobingi.code_dir="/var/lib/nginx/html"

RUN apk add bash vim nginx --update
RUN install -d /run/nginx -o nginx -g www-data

ADD ./nginx.default.conf /etc/nginx/conf.d/default.conf

ENV EXAMPLE=TRIBE

EXPOSE 80

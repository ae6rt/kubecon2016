FROM alpine:3.4

MAINTAINER mpetrovic@paypal.com

RUN apk update && apk add dnsmasq=2.76-r0 jq curl 
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh 

CMD ["/entrypoint.sh"]

FROM wangxunqi/v2ray:latest

COPY config.json /etc/v2ray/

COPY tls.crt /etc/v2ray/

COPY tls.key /etc/v2ray/

EXPOSE 443

CMD ["/usr/bin/v2ray", "-config", "/etc/v2ray/config.json"]

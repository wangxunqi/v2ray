FROM v2ray/official:latest

COPY config.json /etc/v2ray/

USER nobody

EXPOSE 8080

CMD ["/usr/bin/v2ray/v2ray", "-config", "/etc/v2ray/config.json"]

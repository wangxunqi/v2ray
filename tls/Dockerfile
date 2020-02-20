FROM wangxunqi/v2ray:latest

COPY config.json /etc/v2ray/

COPY fullchain.cer /etc/v2ray/

COPY xn--bpwn78e.eu.org.key /etc/v2ray/

USER nobody

EXPOSE 8080

CMD ["/usr/bin/v2ray", "-config", "/etc/v2ray/config.json"]

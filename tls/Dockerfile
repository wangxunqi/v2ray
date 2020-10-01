FROM golang:alpine as builder

WORKDIR /root

RUN apk add --no-cache git build-base; \
    git clone https://github.com/v2fly/v2ray-core.git; \
    cd v2ray-core; \
    go get -u ./...; \
    go build -o /v2ray -ldflags "-s -w" ./main; \
    go build -o /v2ctl -tags confonly -ldflags "-s -w" ./infra/control/main

FROM alpine:latest

RUN apk add --no-cache ca-certificates; \
    mkdir /etc/v2ray

ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat /usr/bin/
ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat /usr/bin/
COPY --from=builder /v2ray  /usr/bin/
COPY --from=builder /v2ctl  /usr/bin/
COPY config.json /etc/v2ray/
COPY tls.crt /etc/v2ray/
COPY tls.key /etc/v2ray/

USER root

EXPOSE 443

CMD ["/usr/bin/v2ray", "-config", "/etc/v2ray/config.json"]

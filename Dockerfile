FROM golang:alpine as builder

RUN apk add --no-cache git build-base; \
    git clone https://github.com/v2ray/v2ray-core.git /src; \
    cd /src; \
    go get -u ./...; \
    cd /src/main; \
    go build -o /v2ray; \
    cd /src/infra/control/main; \
    go build -o /v2ctl

FROM alpine:latest

RUN apk add --no-cache ca-certificates; \
    mkdir /etc/v2ray

ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat /usr/bin/
ADD https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat /usr/bin/
COPY --from=builder /v2ray  /usr/bin/
COPY --from=builder /v2ctl  /usr/bin/
COPY config.json /etc/v2ray/

USER nobody

EXPOSE 8080

CMD ["/usr/bin/v2ray", "-config", "/etc/v2ray/config.json"]

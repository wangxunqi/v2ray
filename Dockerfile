FROM golang:alpine as builder

ENV CGO_ENABLED 0

RUN apk add --no-cache git wget; \
    wget -O /geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat; \
    wget -O /geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat; \
    git clone https://github.com/v2ray/v2ray-core.git $(go env GOPATH)/src/v2ray.com/core; \
    go get -u v2ray.com/core/...; \
    cd $(go env GOPATH)/src/v2ray.com/core/main; \
    go build -o /v2ray; \
    cd $(go env GOPATH)/src/v2ray.com/core/infra/control/main; \
    go build -o /v2ctl

FROM alpine:latest

RUN apk add --no-cache ca-certificates; \
    mkdir /etc/v2ray

COPY --from=builder /geoip.dat /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/
COPY --from=builder /v2ray  /usr/bin/
COPY --from=builder /v2ctl  /usr/bin/
COPY config.json /etc/v2ray/

USER nobody

EXPOSE 8080

CMD ["/usr/bin/v2ray", "-config", "/etc/v2ray/config.json"]

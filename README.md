# A V2Ray container designed for PaaS.
[![Build Status](https://travis-ci.org/wangxunqi/v2ray.svg?branch=tor)](https://travis-ci.org/wangxunqi/v2ray)
```
docker pull wangxunqi/v2ray:tor
docker run --name v2ray --restart=always -d -p 443:8080 -v /path/to/fullchain.cer:/etc/nginx/fullchain.cer:ro -v /path/to/xn--bpwn78e.eu.org.key:/etc/nginx/xn--bpwn78e.eu.org.key:ro wangxunqi/v2ray:tor
```

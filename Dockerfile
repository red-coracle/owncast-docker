FROM golang:alpine as builder

RUN set -ex \
    && apk add --no-cache gcc build-base linux-headers git \
    && git clone --branch develop --single-branch https://github.com/owncast/owncast /owncast \
    && cd /owncast \
    && CGO_ENABLED=1 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o owncast .

FROM alpine:latest

RUN apk add --no-cache ffmpeg ffmpeg-libs ca-certificates && update-ca-certificates \
    && apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing libva-utils libva-intel-driver

WORKDIR /app
COPY --from=builder /owncast/owncast /usr/local/bin
COPY --from=builder /owncast/webroot /app/webroot
COPY --from=builder /owncast/static /app/static

CMD ["/usr/local/bin/owncast"]

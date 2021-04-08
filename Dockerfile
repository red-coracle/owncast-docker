FROM golang:alpine as builder

RUN set -ex \
    && apk add --no-cache gcc build-base linux-headers git \
    && git clone https://github.com/owncast/owncast /owncast \
    && cd /owncast \
    && CGO_ENABLED=1 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o owncast .

FROM alpine:latest

RUN apk add --no-cache ffmpeg ffmpeg-libs ca-certificates && update-ca-certificates

WORKDIR /app
COPY --from=builder /owncast/owncast /usr/local/bin
COPY --from=builder /owncast/webroot /app/webroot
COPY --from=builder /owncast/static /app/static
COPY --from=builder /owncast/data /app/data

CMD ["/usr/local/bin/owncast"]

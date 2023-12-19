FROM golang:1.21.5-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "webdav-server"

FROM alpine:3.18.3

WORKDIR /

COPY --from=builder "/src/webdav-server" "/"

ENTRYPOINT ["/webdav-server"]
EXPOSE 8081

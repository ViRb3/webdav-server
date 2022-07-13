FROM golang:1.18.4-alpine AS builder

WORKDIR /src
COPY . .

RUN apk add --no-cache git && \
    go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "webdav-server"

FROM alpine:3.15.4

WORKDIR /

COPY --from=builder "/src/webdav-server" "/"

ENTRYPOINT ["/webdav-server"]
EXPOSE 8081

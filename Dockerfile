FROM golang:1.17.3-alpine AS builder

WORKDIR /src
COPY . .

RUN go mod download && \
    CGO_ENABLED=0 go build -ldflags="-s -w" -o "webdav-server"

FROM alpine:3.15.1

WORKDIR /

COPY --from=builder "/src/webdav-server" "/"

ENTRYPOINT ["/webdav-server"]
EXPOSE 8081

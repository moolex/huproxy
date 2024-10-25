FROM golang:latest AS builder
WORKDIR /go/src/github.com/google/huproxy
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /go/bin/huproxy ./cmd/huproxy
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /go/bin/huproxyclient ./cmd/huproxyclient

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /go/bin/huproxy /go/bin/huproxyclient ./
CMD ["./huproxy"]

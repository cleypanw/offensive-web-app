# Stage 1: Build Go app
FROM golang:1.21 as builder

WORKDIR /app
COPY main.go .
RUN go build -o app main.go

# Stage 2: Final image
FROM ubuntu:22.04

# Fix DNS et mise à jour fiable + install
RUN cat /etc/resolv.conf && ping -c 3 archive.ubuntu.com || true
RUN apt-get update

# Copier l'app et le beacon
COPY --from=builder /app/app /usr/local/bin/app
COPY beacon-socpoc-mtls-443-cley-evasion /usr/local/bin/beacon
RUN chmod +x /usr/local/bin/*

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/app"]

# Build stage
FROM golang:1.24.4-alpine3.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go 
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.3/migrate.linux-amd64.tar.gz | tar xvz
# RUN mv migrate.linux-amd64 migrate

# Run stage 
FROM alpine:3.21
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY db/migration ./migration
COPY start.sh .
COPY wait-for.sh .
COPY app.env .

EXPOSE 8080
CMD ["/app/main"]
ENTRYPOINT ["/app/start.sh"]
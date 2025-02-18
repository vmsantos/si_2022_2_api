# Build stage
FROM golang:1.19-alpine3.16 AS builder

WORKDIR /app
COPY . .
RUN go build -o main cmd/server/main.go

# Run stage
FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/main .
COPY .env .
COPY application_default_credentials.json .
#COPY wait-for.sh .
#RUN ["chmod", "+x", "/app/wait-for.sh"]

EXPOSE 8080
CMD [ "/app/main" ]

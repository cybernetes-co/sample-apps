FROM golang:latest AS build-env

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build 

FROM alpine:latest
COPY --from=build-env /app /app

EXPOSE 8080
CMD ["/app/web"]

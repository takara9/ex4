# syntax=docker/dockerfile:1
FROM golang:1.22 as build
WORKDIR /app
COPY . .
RUN go mod download && go mod tidy
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./main .

FROM scratch
ENV GIN_MODE=debug
WORKDIR /app
COPY --from=build /app/main /main

USER 65534:65534
EXPOSE 8086
CMD ["/main"]


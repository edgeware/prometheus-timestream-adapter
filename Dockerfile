FROM golang:1.15.3-alpine3.12 as build

WORKDIR /src/prometheus-timestream-adapter
ADD . /src/prometheus-timestream-adapter

RUN apk add build-base

RUN go test
RUN CGO_ENABLED=0 GOOS=linux go build -o /prometheus-timestream-adapter

FROM scratch

COPY --from=build /prometheus-timestream-adapter /usr/local/bin/prometheus-timestream-adapter

ENTRYPOINT ["/usr/local/bin/prometheus-timestream-adapter"]

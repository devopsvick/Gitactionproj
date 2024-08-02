FROM golang:1.22.5 as base 

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o mainbi .

#EXPOSE 8090

#ENTRYPOINT [ "./mainbi" ]

FROM gcr.io/distroless/base

COPY --from=base /app/mainbi .

COPY --from=base /app/static ./static

EXPOSE 8090

ENTRYPOINT [ "./mainbi" ]


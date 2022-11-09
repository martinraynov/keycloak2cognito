FROM alpine:3.15.0

WORKDIR /app

RUN apk add --no-cache \
    coreutils

CMD [ "/app/migration_script.sh" ]

VOLUME [ "/app" ]

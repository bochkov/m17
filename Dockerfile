FROM nimlang/nim:latest-alpine AS builder
RUN apk add --no-cache libpq pcre tzdata
COPY src .
RUN nim --version
RUN nimble install jester -y
RUN nim c -d:release --threads:on app.nim

FROM alpine
RUN apk add --no-cache libpq pcre tzdata
RUN cp /usr/share/zoneinfo/America/New_York /etc/localtime  \
    && echo "America/New_York" > /etc/timezone \
    && apk del tzdata
RUN mkdir /m17
WORKDIR /m17
COPY --from=builder app .
EXPOSE 5000
ENTRYPOINT ["./app"]

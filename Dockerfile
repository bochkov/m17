FROM nimlang/nim:latest-alpine AS builder
RUN apk add --no-cache libpq pcre tzdata
COPY src .
RUN nim --version
RUN nimble install rosencrantz -y
RUN nim c -d:release app.nim

FROM alpine
RUN apk add --no-cache libpq pcre tzdata
RUN cp /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime  \
    && echo "Asia/Yekaterinburg" > /etc/timezone \
    && apk del tzdata
RUN mkdir /m17
WORKDIR /m17
COPY --from=builder app .
EXPOSE 5000
ENTRYPOINT ["./app"]
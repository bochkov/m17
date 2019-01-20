FROM nimlang/nim:alpine AS builder
COPY src .
RUN nimble install jester -y
RUN nim c -d:release app.nim

FROM alpine
RUN apk add --no-cache libpq pcre
RUN mkdir /m17
WORKDIR /m17
COPY --from=builder app .
EXPOSE 5000
CMD ["./app"]
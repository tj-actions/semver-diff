FROM alpine:3.15.4

LABEL maintainer="Tonye Jack <jtonye@ymail.com>"

RUN apk add wget bash git openssh grep sed

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM alpine:edge


RUN apk --no-cache add squid tor privoxy ca-certificates && \
    apk add --no-cache obfs4proxy --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && \
    ln -sf /dev/stdout /var/log/privoxy/logfile && \
    chown -R squid:squid /var/cache/squid && \
    chown -R squid:squid /var/log/squid

COPY service /opt/

ENV OBFS4_ADR="obfs4 207.148.108.221:443 7259F29EC35E385B25D1DD56A3B39B76BBE63940 cert=aMu33DOPGFQsjgLZ7JtKB6Eysn9kaN4ubcWbi2zsO+rAORC1eKDrDiGqXqkJD8ZLgY25QA iat-mode=0"

EXPOSE 8888

CMD ["/bin/sh", "/opt/start.sh"]

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
ARG REVISION=
LABEL org.opencontainers.image.title="tor bridge providing obfs4 obfuscation protocol with squid" \
    org.opencontainers.image.source="https://github.com/iAHTOH/ docker-tor-proxy" \
    org.opencontainers.image.revision="$REVISION"

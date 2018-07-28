FROM alpine:3.8

RUN apk add --no-cache bash curl

RUN curl https://getcaddy.com | bash -s personal http.cache,http.cors,http.expires,http.filemanager,http.git,http.realip,tls.dns.digitalocean

# validate install
RUN /usr/local/bin/caddy -version
RUN /usr/local/bin/caddy -plugins

# Let's Encrypt Agreement
ENV ACME_AGREE="true"

EXPOSE 80 443 2015
VOLUME /root/.caddy /srv
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout", "--agree=$ACME_AGREE"]
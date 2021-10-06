FROM amd64/ubuntu
LABEL author="groovestreetmagic@gmail.com" source="https://github.com/spirtum/dante"

ADD ./sockd.conf /etc
ADD ./docker-entrypoint.sh /

RUN apt update && \
    apt install --no-install-recommends -y build-essential wget ca-certificates && \
    wget https://www.inet.no/dante/files/dante-1.4.3.tar.gz && \
    tar xfz dante-1.4.3.tar.gz && \
    cd dante-1.4.3 && \
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-client \
    --without-libwrap --without-bsdauth --without-gssapi --without-krb5 --without-upnp --without-pam && \
    make && \
    make install && \
    cd .. && \
    rm -rf /dante-1.4.3 dante-1.4.3.tar.gz && \
    apt purge -y --auto-remove build-essential wget ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
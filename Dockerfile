FROM alpine:3.2
MAINTAINER Jaka Hudoklin <jakahudoklin@gmail.com>

# Install openvpn
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    apk add --update openvpn iptables bash && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

# Configuration files
ENV OVPN_CONFIG /etc/openvpn/openvpn.conf
ADD openvpn.conf /etc/openvpn/openvpn.conf

# Expose tcp and udp port
EXPOSE 1194/tcp
EXPOSE 1194/udp

WORKDIR /etc/openvpn

# entry point takes care of setting conf values
COPY entrypoint.sh /sbin/entrypoint.sh

CMD ["/sbin/entrypoint.sh"]

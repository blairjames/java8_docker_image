FROM alpine:20200626@sha256:156f59dc1cbe233827642e09ed06e259ef6fa1ca9b2e29d52ae14d5e7b79d7f0
RUN apk add --no-cache \
    curl \
    openssh-client \
    git \
    util-linux \
    openjdk8 \
    maven
CMD ["/bin/sh"]

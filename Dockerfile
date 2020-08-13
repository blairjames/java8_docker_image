FROM alpine:20200626@sha256:156f59dc1cbe233827642e09ed06e259ef6fa1ca9b2e29d52ae14d5e7b79d7f0
RUN apk add --no-cache \
    openssh-client \
    curl \
    git \
    util-linux \
    openjdk8 \
    maven \
    spring-boot-openrc \
    junit \
    jetty-runner \
    jetty-runner-openrc 
RUN git clone https://github.com/spring-projects/spring-framework.git
RUN cd spring-framework && ./gradlew build
RUN git clone https://github.com/spring-projects/spring-boot.git
RUN cd spring-boot && ./gradlew build
RUN git clone https://github.com/spring-projects/spring-security.git
RUN cd spring-security && ./gradlew install && ./gradlew build
RUN git clone https://github.com/spring-projects/spring-data-keyvalue.github
RUN cd spring-data-keyvalue && ./mvnw clean install
RUN git clone https://github.com/spring-projects/spring-data-jdbc.git
RUN cd spring-data-jdbc && ./mvnw clean install
CMD ["/bin/sh"]


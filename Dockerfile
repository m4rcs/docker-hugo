FROM alpine:latest

# Hugo Versions
ENV HUGO_VERSION 0.56.1
ENV HUGO_CHECKSUM af68761aaae76954cfd78a99b310143998efb629e47d2048f8e24b3311f23a28

# Container Annotations based on https://github.com/opencontainers/image-spec/blob/master/annotations.md
ARG IMAGE_REVISION=1
ARG IMAGE_BUILD_TIME
LABEL org.opencontainers.image.authors="@m4rcs" \
    org.opencontainers.image.created="${IMAGE_BUILD_TIME}" \
    org.opencontainers.image.description="The world’s fastest framework for building websites."\
    org.opencontainers.image.documentation="https://github.com/m4rcs/docker-hugo" \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.revision="${IMAGE_REVISION}" \
    org.opencontainers.image.source="https://github.com/m4rcs/docker-hugo.git" \
    org.opencontainers.image.title="Docker Hugo" \
    org.opencontainers.image.url="https://github.com/m4rcs/docker-hugo" \
    org.opencontainers.image.vendor="GoHugo.io" \
    org.opencontainers.image.version="v${HUGO_VERSION}"

# Download required files and packages, check them and install hugo into the path
WORKDIR /tmp
RUN apk add --no-cache ca-certificates libc6-compat libstdc++
RUN wget -q https://github.com/gohugoio/hugo/releases/download/v0.56.1/hugo_extended_0.56.1_Linux-64bit.tar.gz && \
    echo "${HUGO_CHECKSUM}  hugo_extended_0.56.1_Linux-64bit.tar.gz" | sha256sum -cs - && \
    tar xfz hugo_extended_0.56.1_Linux-64bit.tar.gz && \
    mv /tmp/hugo /usr/bin && \
    rm -rf /tmp/* && \
    mkdir /site

# Put the source of your site into /site
WORKDIR /site
VOLUME [ "/site" ]
EXPOSE 1313

# Run hugo
CMD [ "/usr/bin/hugo" ]

FROM ubuntu:precise

# Set locale to fix character encoding
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies and utilities
RUN apt-get update && apt-get install -y \
  devscripts \
  debhelper \
  gawk \
  libsigsegv2 \
  wget \
  debian-keyring \
  less \
  vim 

WORKDIR /build

ARG version
RUN wget https://launchpad.net/ubuntu/+archive/primary/+files/linux-meta-lts-trusty_${version}.tar.gz
RUN wget https://launchpad.net/ubuntu/+archive/primary/+files/linux-meta-lts-trusty_${version}.dsc
RUN dpkg-source -x linux-meta-lts-trusty_${version}.dsc
RUN cd linux-meta-lts-trusty-${version} && debuild -i -uc -us
RUN ls

WORKDIR /packages
RUN mv /build/* /packages/

# Copy build packages to volume
VOLUME /out
CMD cp /packages/* /out/

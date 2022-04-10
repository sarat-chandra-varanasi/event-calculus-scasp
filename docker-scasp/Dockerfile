FROM debian:bullseye-slim
LABEL maintainer "Dave Curylo <dave@curylo.org>, Michael Hendricks <michael@ndrix.org>"
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libtcmalloc-minimal4 \
    libarchive13 \
    libyaml-dev \
    libgmp10 \
    libossp-uuid16 \
    libssl1.1 \
    ca-certificates \
    libdb5.3 \
    libpcre3 \
    libedit2 \
    libgeos-3.9.0 \
    libspatialindex6 \
    unixodbc \
    odbc-postgresql \
    tdsodbc \
    libmariadbclient-dev-compat \
    libsqlite3-0 \
    libserd-0-0 \
    curl \ 
    gcc \ 
    gcc-multilib \
    libc6-i386 \
    libc6-dev-i386 \
    g++-multilib \
    libraptor2-0 && \
    dpkgArch="$(dpkg --print-architecture)" && \
    rm -rf /var/lib/apt/lists/*
ENV LANG C.UTF-8
RUN mkdir -p /ciao
RUN git clone https://github.com/ciao-lang/ciao.git /ciao
RUN cd /ciao; ./ciao-boot.sh configure; ./ciao-boot.sh build ; ./ciao-boot.sh global-install
RUN  apt-get purge -y --auto-remove $BUILD_DEPS
RUN ciao get gitlab.software.imdea.org/ciao-lang/sCASP


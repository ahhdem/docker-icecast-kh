FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive
ENV IC_VERSION "2.4.0-kh14"

COPY etc/apt /etc/apt
RUN apt-get -qq -y update && \
	apt-get -qq -y install \
    build-essential \
		wget \
    curl \
    libxml2-dev \
    libxslt1-dev \
		libogg-dev \
    libvorbis-dev \
    libtheora-dev \
		libspeex-dev \
    procps \
  dumb-init  && \
  mv /etc/apt/sources.list /etc/apt/sources.list.d/stable.list && \
  apt-get -qq -y update && \
  apt-get -y install ezstream && \
  wget "https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz" -O- | tar zxvf - && \
  cd "icecast-kh-icecast-$IC_VERSION" && \
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
  make && make install && \
  apt-get purge --auto-remove -y \
    build-essential \
    curl \
    gcc \
    wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache && \
  useradd icecast

VOLUME ["/etc/icecast", "/var/log/icecast"]
RUN chown -R icecast:icecast /etc/icecast/ /var/log/icecast/
RUN chown -R icecast:icecast /etc/icecast/ /var/log/icecast/ && ls -alhrt /etc/icecast

USER icecast
RUN id

COPY scripts /
COPY silence.mp3 /

EXPOSE 8000
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]

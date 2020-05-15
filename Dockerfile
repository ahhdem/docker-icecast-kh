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
  dumb-init  && \
  mv /etc/apt/sources.list /etc/apt/sources.list.d/stable.list && \
  apt-get -qq -y update && \
  apt-get -y install ezstream && \
  wget "https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz" -O- | tar zxvf - && \
  cd "icecast-kh-icecast-$IC_VERSION" && \
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
  make && make install && useradd icecast && \
  apt-get purge --auto-remove -y \
    build-essential \
    curl \
    gcc \
    wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

COPY etc/icecast /etc/icecast
RUN mv /etc/icecast.xml /etc/icecast && \
	chown -R icecast /etc/icecast

COPY scripts /
COPY silence.mp3 /

EXPOSE 8000
VOLUME ["/config", "/var/log/icecast"]
USER icecast
CMD ["/start.sh"]

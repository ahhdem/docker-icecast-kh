FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive

ENV IC_VERSION "2.4.0-kh14"

EXPOSE 8000
VOLUME ["/config", "/var/log/icecast"]

COPY etc /etc
COPY scripts /
COPY silence.mp3 /

RUN apt-get -qq -y update && \
	apt-get -qq -y install build-essential \
		wget curl libxml2-dev libxslt1-dev \
		libogg-dev libvorbis-dev libtheora-dev \
		libspeex-dev python-pip  && \
    pip install supervisor supervisor-stdout && \
    mv /etc/apt/sources.list /etc/apt/sources.list.d/stable.list && \
    apt-get -qq -y update && \
    apt-get -y install ezstream

RUN wget "https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz" -O- | tar zxvf - && \
	cd "icecast-kh-icecast-$IC_VERSION" && \
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && \
	make && make install && useradd icecast && \
	chown -R icecast /etc/icecast.xml /etc/ezstream.xml

USER icecast
CMD ["/start.sh"]

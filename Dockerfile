ARG DEB_VER=sid
FROM debian:${DEB_VER}-slim
LABEL maintainer="Amitie10g <davidkingnt@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG PACKAGES="g++"
ARG ARCH="x86_64-linux-gnu"

RUN	apt-get update && \
	apt-get -y --no-install-recommends install make file && \
	apt-get -y install ${PACKAGES} && \
	apt-get clean && \
 	if [ "$ARCH" != "x86_64-linux-gnu" ]; then \
		for file in /usr/bin/${ARCH}*; do \
			alternative=$(basename $file); \
			update-alternatives --install /usr/local/bin/${alternative#${ARCH}-} ${alternative} ${file} 1; \
		done \
  	fi

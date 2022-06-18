ARG TAG=latest
ARG NAMESPACE=resin
FROM ${NAMESPACE}/yocto-build-env:${TAG} AS os_builder

# Need version 3.20.2 for the --include support
RUN curl -LO 'https://github.com/inotify-tools/inotify-tools/releases/download/3.20.2.2/inotify-tools-3.20.2.2.tar.gz' && \
		tar xzvf inotify-tools-3.20.2.2.tar.gz && \
		cd inotify-tools-3.20.2.2 && \
		./configure --prefix=/usr --libdir=/lib64 && \
		make && \
		make install

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

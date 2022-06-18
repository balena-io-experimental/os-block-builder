ARG TAG=latest
ARG NAMESPACE=resin
FROM ${NAMESPACE}/yocto-build-env:${TAG} AS os_builder

COPY balena.yml entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

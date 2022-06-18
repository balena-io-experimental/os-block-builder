#!/bin/bash
set -e

[ "${VERBOSE}" = "verbose" ] && set -x

workdir="/work"
# Wait for build to be available
inotifywait "${workdir}" -e create -t ${FEED_TIMEOUT} --include "os-builder-ready"

finish() {
	rm "${workdir}/os-builder-ready"
}
trap finish EXIT ERR
chmod +st "${workdir}"
if [ ! -f "${workdir}/repo.yml" ]; then
	echo "Working directory in use does not contain a Balena device repository" && exit 1;
elif ! grep -q 'yocto-based OS image' "${workdir}/repo.yml"; then
	echo "Working directory in use does not contain a Balena device repository" && exit 1;
fi

BITBAKE_TARGETS="--bitbake-target os-release package-index"
chown -R "${BUILDER_GID}":"${BUILDER_UID}" "${workdir}"
pushd "${workdir}"
/prepare-and-start.sh \
	--log \
	--machine "${MACHINE}" \
	--shared-downloads "${workdir}/shared-downloads" \
	--shared-sstate "${workdir}/${MACHINE}/shared-sstate" \
	--skip-discontinued \
	--rm-work \
	${BITBAKE_TARGETS}

# Flag as ready
touch "${workdir}/package-index-ready"


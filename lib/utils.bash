#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/CycloneDX/cyclonedx-cli"
TOOL_NAME="cyclonedx"
TOOL_TEST="cyclonedx --version"

if [[ -n "${CI-}" ]]; then
	echo >&2 "CI mode detected"
	set -x
fi

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

OS=""
ARCH=""
UNAME_OUTPUT="$(uname -s)"
MACHINE_TYPE="$(uname -m)"

# Determine OS
case "${UNAME_OUTPUT}" in
Linux*)
	OS="linux"
	;;
Darwin*)
	OS="osx"
	;;
*)
	fail "Unsupported operating system: ${UNAME_OUTPUT}"
	;;
esac

# Determine architecture
case "${MACHINE_TYPE}" in
x86_64)
	ARCH="x64"
	;;
arm64)
	ARCH="arm64"
	;;
aarch64)
	ARCH="arm64"
	;;
arm*)
	ARCH="arm"
	;;
*)
	fail "Unsupported architecture: ${MACHINE_TYPE}"
	;;
esac

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	binary="cyclonedx-${OS}-${ARCH}"
	url="$GH_REPO/releases/download/v${version}/${binary}"
	echo "* Downloading $TOOL_NAME release $version..."
	rm -f "$filename"

	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || (
		fail "Could not download $url"
	)

	chmod +x "$filename"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

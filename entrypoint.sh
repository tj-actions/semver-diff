#!/usr/bin/env bash

set -euo pipefail

GITHUB_OUTPUT=${GITHUB_OUTPUT:-}

if [[ $GITHUB_REF != "refs/tags/"* ]]; then
  echo "::warning::Skipping: This should only run on tags push or on release instead of '$GITHUB_EVENT_NAME'.";
  exit 0;
fi

git fetch origin +refs/tags/*:refs/tags/*

NEW_TAG=${4:-"${GITHUB_REF/refs\/tags\//}"}
CURRENT_TAG=${3:-$(git tag -l --sort=-version:refname "*.*" | grep -v "$NEW_TAG" | head -1 || true)}

if [[ -z $CURRENT_TAG ]]; then
  echo "::warning::Initial release detected unable to determine any tag diff."
  echo "::warning::Setting release_type to $INPUT_INITIAL_RELEASE_TYPE."
  echo "release_type=$INPUT_INITIAL_RELEASE_TYPE" >> "$GITHUB_OUTPUT"
  exit 0;
fi

echo "::debug::Calculating diff..."
PART=$(wget -O - https://raw.githubusercontent.com/fsaintjacques/semver-tool/3.3.0/src/semver | bash -s diff "${CURRENT_TAG//v/}" "${NEW_TAG//v/}")

cat <<EOF >> "$GITHUB_OUTPUT"
release_type=$PART
old_version=$CURRENT_TAG
new_version=$NEW_TAG
EOF

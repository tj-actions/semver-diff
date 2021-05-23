#!/usr/bin/env bash

set -e

if [[ $GITHUB_REF != "refs/tags/"* ]]; then
  echo "Skipping: This should only run on tags push or on release instead of '$GITHUB_EVENT_NAME'.";
  exit 0;
fi

git remote set-url origin "https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY"

git fetch origin +refs/tags/*:refs/tags/*

CURRENT_TAG=${3:-$(git describe --abbrev=0 --tags "$(git rev-list --tags --skip=1  --max-count=1)" || true)}
NEW_TAG=${4:-"${GITHUB_REF/refs\/tags\//}"}

if [[ -z $CURRENT_TAG ]]; then
  echo "::warning::Initial release detected unable to determine any tag diff."
  echo "::warning::Setting release_type to $INPUT_INITIAL_RELEASE_TYPE."
  echo "::set-output name=release_type::$INPUT_INITIAL_RELEASE_TYPE"
  exit 0;
fi



PART=$(wget -O - https://raw.githubusercontent.com/fsaintjacques/semver-tool/3.2.0/src/semver | bash -s diff "${CURRENT_TAG/v//}" "${NEW_TAG/v//}")
echo "::set-output name=release_type::$PART"

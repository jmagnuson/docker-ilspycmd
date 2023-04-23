#!/usr/bin/env bash

VERSION="$(curl -fsSL 'https://api.github.com/repos/icsharpcode/ilspy/releases/latest' | \
  jq -r .tag_name)"
VERSION=${VERSION/v/}

docker buildx build \
  -t "ghcr.io/jessenich/ilspycmd:$VERSION" \
  --load \
  --file prerelease.Dockerfile \
  .

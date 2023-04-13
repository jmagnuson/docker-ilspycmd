#!/usr/bin/env bash

docker buildx build \
  -t jessenich91/ilspycmd:7.2 \
  -t jessenich91/ilspycmd:7.2.1 \
  -t ilspycmd \
  --load \
  .

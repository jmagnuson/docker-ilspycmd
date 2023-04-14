#!/usr/bin/env bash

docker buildx build \
  -t jessenich/ilspycmd:7.2.1 \
  --load \
  .

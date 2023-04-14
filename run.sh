#!/usr/bin/env bash

# shellcheck disable=SC2046,SC2086

DLL=$1
PDB=${1//.dll/.pdb} # | sed s/\.dll/\.pdb/g)
OUT=$2
docker run \
  --volume "$DLL:/data/in/$(basename $DLL)" \
  --volume "$PDB:/data/in/$(basename $PDB)" \
  --volume "$OUT:/data/out" \
  --rm \
  jessenich91/ilspycmd:7.2.1 \
  --outputdir "/data/out" \
  --use-varnames-from-pdb \
  --generate-pdb \
  --project \
  --no-dead-code \
  --no-dead-stores \
  --dump-package \
  /data/in/$(basename $DLL)

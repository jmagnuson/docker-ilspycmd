#!/usr/bin/env bash

DLL=$1
PDB=${1//.dll/.pdb} # | sed s/\.dll/\.pdb/g)
OUT=$2
docker run \
  --volume "$DLL:/data/in/$(basename $DLL)" \
  --volume "$PDB:/data/in/$(basename $PDB)" \
  --volume "$OUT:/data/out" \
  --rm \
  ilspycmd:1.0-dev \
  --outputdir "/data/out" \
  --use-varnames-from-pdb \
  --generate-pdb \
  --project \
  --no-dead-code \
  --no-dead-stores \
  --dump-package \
  /data/in/$(basename $DLL)

#!/usr/bin/env bash

sed -E 's/FOOPS/if/g' /home/woodriir/241/prog.c | sed -E 's/BEEPBOOP/\/\*\*/g' > MyFile.c



#!/bin/bash

for f in `find raw_assets -name '*.pack' | xargs dirname | cut -d '/' -f 2`; do
  echo "Updating $f"
  cp "raw_assets/$f/$f.pack" "assets/data/atlases/"
  cp "raw_assets/$f/$f.png"  "assets/images/"
done

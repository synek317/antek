#!/bin/bash

for f in `find raw_assets -name '*.pack' | xargs dirname | cut -d '/' -f 2`; do
  echo "Updating $f"
  sed -E s/\\r//g "raw_assets/$f/$f.pack" > "assets/data/atlases/$f.pack"
  cp "raw_assets/$f/$f.png"  "assets/images/"
done

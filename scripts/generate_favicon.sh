#!/bin/bash

rm -rf build/
mkdir -p build/

mkdir -p font/
curl https://fonts.gstatic.com/s/lobster/v28/neILzCirqoswsqX9_oU.ttf > font/Lobster-Regular.ttf

# Draw an 'S' in the Lobster-Regular font
convert \
  -size 256x256 \
  xc:none \
  -gravity center \
  -background none \
  -font font/Lobster-Regular.ttf \
  -pointsize 256 \
  -fill black \
  -draw "text 5,5 'S'" \
  -fill lightgreen \
  -draw "text -5,-5 'S'" \
  build/letter.png

# Create the outer rounded rectangle
convert \
  -size 256x256 xc:none \
  -fill green \
  -draw "roundrectangle 0,0,256,256,80,80" \
  build/rect1.png

# Create the middle rounded rectangle
convert \
  -size 256x256 xc:none \
  -fill "#004400" \
  -draw "roundrectangle 15,15,241,241,66,66" \
  build/rect2.png

# Create the inner rounded rectangle
convert \
  -size 256x256 xc:none \
  -fill darkgreen \
  -draw "roundrectangle 20,20,236,236,60,60" \
  build/rect3.png

# Combine the outer and middle rectangles
convert \
  -composite \
  build/rect1.png \
  build/rect2.png \
  build/out1.png

# Combine with the inner rectangle as well
convert \
  -composite \
  build/out1.png \
  build/rect3.png \
  build/out2.png

# Combine the letter and the background rectangles
convert \
  -composite \
  build/out2.png \
  build/letter.png \
  build/out3.png

# Finally, convert to an icon file
convert build/out3.png build/favicon.ico

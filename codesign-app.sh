#!/bin/bash

LIBSHORT=\
('libX11.6.dylib' \
'libXau.6.dylib' \
'libXdmcp.6.dylib' \
'libXext.6.dylib' \
'libXrender.1.dylib' \
'libatk-1.0.0.dylib' \
'libcairo-gobject.2.dylib' \
'libcairo.2.dylib' \
'libepoxy.0.dylib' \
'libfftw3.3.dylib' \
'libfontconfig.1.dylib' \
'libfreetype.6.dylib' \
'libfribidi.0.dylib' \
'libgdk-3.0.dylib' \
'libgdk_pixbuf-2.0.0.dylib' \
'libgio-2.0.0.dylib' \
'libglib-2.0.0.dylib' \
'libgmodule-2.0.0.dylib' \
'libgobject-2.0.0.dylib' \
'libgraphite2.3.dylib' \
'libgtk-3.0.dylib' \
'libharfbuzz.0.dylib' \
'libintl.8.dylib' \
'libjpeg.8.dylib' \
'libpango-1.0.0.dylib' \
'libpangocairo-1.0.0.dylib' \
'libpangoft2-1.0.0.dylib' \
'libpcre2-8.0.dylib' \
'libpixman-1.0.dylib' \
'libpng16.16.dylib' \
'libportaudio.2.dylib' \
'libxcb-render.0.dylib' \
'libxcb-shm.0.dylib' \
'libxcb.1.dylib')

SIGNID="Developer ID Application: Transition Technology Ventures, LLC (6V82P5ET42)"
DSTDIR=pihpsdr.app/Contents/Frameworks/

xattr -cr pihpsdr.app

echo "----- Fix Executable Code Signature"

codesign --remove-signature pihpsdr.app/Contents/MacOS/pihpsdr
codesign -vf --timestamp --options runtime --sign "$SIGNID" pihpsdr.app/Contents/MacOS/pihpsdr

echo "---------  Fix Library Code Signatures"

for library in ${LIBSHORT[*]}
do
  echo $library
  codesign --remove-signature $DSTDIR/$library
  codesign -vf --timestamp --options runtime --sign "$SIGNID" $DSTDIR/$library
done


echo "----- Fix App Code Signature"

echo "app remove"
codesign --remove-signature pihpsdr.app
echo "app sign"
codesign -vf --timestamp --options runtime --sign "$SIGNID" pihpsdr.app

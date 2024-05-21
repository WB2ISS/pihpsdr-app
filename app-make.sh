#!/bin/bash

EXECUTABLE=pihpsdr
SRCAPPDIR=../pihpsdr-dl1ycf

APPLICATION=$EXECUTABLE.app
FRAMEWORKS=$APPLICATION/Contents/Frameworks
MACOS=$APPLICATION/Contents/MacOS
EXECUTABLEPATH=@executable_path/../Frameworks

LIBLONG=\
('/opt/homebrew/Cellar/cairo/1.18.0/lib/libcairo.2.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libglib-2.0.0.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libgmodule-2.0.0.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libgobject-2.0.0.dylib' \
'/opt/homebrew/Cellar/gtk+3/3.24.41/lib/libgdk-3.0.dylib' \
'/opt/homebrew/Cellar/libxcb/1.17.0/lib/libxcb.1.dylib' \
'/opt/homebrew/Cellar/pango/1.52.2/lib/libpango-1.0.0.dylib' \
'/opt/homebrew/Cellar/pango/1.52.2/lib/libpangoft2-1.0.0.dylib' \
'/opt/homebrew/opt/at-spi2-core/lib/libatk-1.0.0.dylib' \
'/opt/homebrew/opt/cairo/lib/libcairo-gobject.2.dylib' \
'/opt/homebrew/opt/cairo/lib/libcairo.2.dylib' \
'/opt/homebrew/opt/fftw/lib/libfftw3.3.dylib' \
'/opt/homebrew/opt/fontconfig/lib/libfontconfig.1.dylib' \
'/opt/homebrew/opt/freetype/lib/libfreetype.6.dylib' \
'/opt/homebrew/opt/fribidi/lib/libfribidi.0.dylib' \
'/opt/homebrew/opt/gdk-pixbuf/lib/libgdk_pixbuf-2.0.0.dylib' \
'/opt/homebrew/opt/gettext/lib/libintl.8.dylib' \
'/opt/homebrew/opt/glib/lib/libgio-2.0.0.dylib' \
'/opt/homebrew/opt/glib/lib/libglib-2.0.0.dylib' \
'/opt/homebrew/opt/glib/lib/libgmodule-2.0.0.dylib' \
'/opt/homebrew/opt/glib/lib/libgobject-2.0.0.dylib' \
'/opt/homebrew/opt/graphite2/lib/libgraphite2.3.dylib' \
'/opt/homebrew/opt/gtk+3/lib/libgdk-3.0.dylib' \
'/opt/homebrew/opt/gtk+3/lib/libgtk-3.0.dylib' \
'/opt/homebrew/opt/harfbuzz/lib/libharfbuzz.0.dylib' \
'/opt/homebrew/opt/jpeg-turbo/lib/libjpeg.8.dylib' \
'/opt/homebrew/opt/libepoxy/lib/libepoxy.0.dylib' \
'/opt/homebrew/opt/libpng/lib/libpng16.16.dylib' \
'/opt/homebrew/opt/libx11/lib/libX11.6.dylib' \
'/opt/homebrew/opt/libxau/lib/libXau.6.dylib' \
'/opt/homebrew/opt/libxcb/lib/libxcb-render.0.dylib' \
'/opt/homebrew/opt/libxcb/lib/libxcb-shm.0.dylib' \
'/opt/homebrew/opt/libxcb/lib/libxcb.1.dylib' \
'/opt/homebrew/opt/libxdmcp/lib/libXdmcp.6.dylib' \
'/opt/homebrew/opt/libxext/lib/libXext.6.dylib' \
'/opt/homebrew/opt/libxrender/lib/libXrender.1.dylib' \
'/opt/homebrew/opt/pango/lib/libpango-1.0.0.dylib' \
'/opt/homebrew/opt/pango/lib/libpangocairo-1.0.0.dylib' \
'/opt/homebrew/opt/pango/lib/libpangoft2-1.0.0.dylib' \
'/opt/homebrew/opt/pcre2/lib/libpcre2-8.0.dylib' \
'/opt/homebrew/opt/pixman/lib/libpixman-1.0.dylib' \
'/opt/homebrew/opt/portaudio/lib/libportaudio.2.dylib')


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


for library in ${LIBLONG[*]}
do
  ls -l $library
done

cp -rp $SRCAPPDIR/$APPLICATION .

echo "------ Executable before change:"
otool -l $MACOS/$EXECUTABLE | grep brew

echo "------ Changing executable"
for library in ${LIBLONG[*]}
do
  install_name_tool -change $library @rpath/$(basename $library) $MACOS/$EXECUTABLE
done

echo "------ Executable after change:"
otool -L $MACOS/$EXECUTABLE | grep rpath

echo "------ Adding @rpath to executable"
install_name_tool -add_rpath $EXECUTABLEPATH $MACOS/$EXECUTABLE

echo "------ New @rpath:"
otool -l $MACOS/$EXECUTABLE |grep -A4 LC_RPATH

echo "--- Copying Libraries and Setting Install Name"
for library in ${LIBLONG[*]}
do
  cp -f $library $FRAMEWORKS
  install_name_tool -id @rpath/$(basename $library) $FRAMEWORKS/$(basename $library) 2>/dev/null
  otool -D $FRAMEWORKS/$(basename $library)
done

echo "---------  Checking Libraries"
for library in ${LIBSHORT[*]}
do
  echo =====  $library
  ls -l $FRAMEWORKS/$library
  otool -l $FRAMEWORKS/$library |grep brew
  echo " "
done

echo "---------  Adjusting Library Paths"
for library in ${LIBSHORT[*]}
do
  for path in ${LIBLONG[*]}
  do
      install_name_tool -change $path @rpath/$(basename $path) $FRAMEWORKS/$library 2>/dev/null
  done
done

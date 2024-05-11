#!/bin/bash


SRCDIR=/opt/homebrew/opt/
DSTDIR=pihpsdr.app/Contents/Frameworks/
EXEDIR=pihpsdr.app/Contents/MacOS/
RPATH=@executable_path/../Frameworks/

LIBRARIES=\
('portaudio/lib/libportaudio.2.dylib' \
 'gtk+3/lib/libgtk-3.0.dylib' \
 'gtk+3/lib/libgdk-3.0.dylib' \
 'pango/lib/libpangocairo-1.0.0.dylib' \
 'pango/lib/libpango-1.0.0.dylib' \
 'harfbuzz/lib/libharfbuzz.0.dylib' \
 'at-spi2-core/lib/libatk-1.0.0.dylib' \
 'cairo/lib/libcairo-gobject.2.dylib' \
 'cairo/lib/libcairo.2.dylib' \
 'gdk-pixbuf/lib/libgdk_pixbuf-2.0.0.dylib' \
 'glib/lib/libgio-2.0.0.dylib' \
 'glib/lib/libgobject-2.0.0.dylib' \
 'glib/lib/libglib-2.0.0.dylib' \
 'gettext/lib/libintl.8.dylib' \
 'fftw/lib/libfftw3.3.dylib')

LIBSHORT=\
('libportaudio.2.dylib' \
 'libgtk-3.0.dylib' \
 'libgdk-3.0.dylib' \
 'libpangocairo-1.0.0.dylib' \
 'libpango-1.0.0.dylib' \
 'libharfbuzz.0.dylib' \
 'libatk-1.0.0.dylib' \
 'libcairo-gobject.2.dylib' \
 'libcairo.2.dylib' \
 'libgdk_pixbuf-2.0.0.dylib' \
 'libgio-2.0.0.dylib' \
 'libgobject-2.0.0.dylib' \
 'libglib-2.0.0.dylib' \
 'libintl.8.dylib' \
 'libfftw3.3.dylib')

for library in ${LIBRARIES[*]}
do
  ls -l $SRCDIR$library
done

mkdir -p $DSTDIR
mkdir -p $EXEDIR

cp pihpsdr $EXEDIR

echo "Before change:"
otool -L $EXEDIR/pihpsdr

for library in ${LIBRARIES[*]}
do
  install_name_tool -change $SRCDIR$library @rpath/$library $EXEDIR/pihpsdr
done

echo ------
echo "After change:"
otool -L $EXEDIR/pihpsdr

install_name_tool -add_rpath $RPATH $EXEDIR/pihpsdr
echo ------
echo "New rpath:"
otool -l $EXEDIR/pihpsdr |grep -A4 LC_RPATH

for library in ${LIBRARIES[*]}
do
  cp $SRCDIR$library $DSTDIR
done

echo "---------"
echo "Checking Libraries"

for library in ${LIBSHORT[*]}
do
  echo =====  $library
  ls -l $DSTDIR$library
  otool -l $DSTDIR$library |grep brew
done

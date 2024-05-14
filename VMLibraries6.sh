#!/bin/bash

LIBLONG=\
('/opt/homebrew/Cellar/cairo/1.18.0/lib/libcairo.2.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libglib-2.0.0.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libgmodule-2.0.0.dylib' \
'/opt/homebrew/Cellar/glib/2.80.0_2/lib/libgobject-2.0.0.dylib' \
'/opt/homebrew/Cellar/gtk+3/3.24.41/lib/libgdk-3.0.dylib' \
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
'/opt/homebrew/opt/libxcb/lib/libxcb-render.0.dylib' \
'/opt/homebrew/opt/libxcb/lib/libxcb-shm.0.dylib' \
'/opt/homebrew/opt/libxcb/lib/libxcb.1.dylib' \
'/opt/homebrew/opt/libxext/lib/libXext.6.dylib' \
'/opt/homebrew/opt/libxrender/lib/libXrender.1.dylib' \
'/opt/homebrew/opt/pango/lib/libpango-1.0.0.dylib' \
'/opt/homebrew/opt/pango/lib/libpangocairo-1.0.0.dylib' \
'/opt/homebrew/opt/pango/lib/libpangoft2-1.0.0.dylib' \
'/opt/homebrew/opt/pcre2/lib/libpcre2-8.0.dylib' \
'/opt/homebrew/opt/pixman/lib/libpixman-1.0.dylib' \
'/opt/homebrew/opt/portaudio/lib/libportaudio.2.dylib')



for library in ${LIBLONG[*]}
do
   otool -l $library | grep brew | grep name | awk '{print $2}'
   echo " "
done

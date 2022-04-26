use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Object;

use GDK::RGBA;

use GLib::Roles::Pointers;

constant dazzle is export = 'dazzle-1.0',v0;

class DzlAnimation        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphColumn        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphModel         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphView          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphRenderer      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFlowBox is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutChordTable is repr<CPointer> does GLib::Roles::Pointers is export { }

class DazzleGraphView       is repr<CPointer> does GLib::Roles::Pointers is export { }
class DazzleCPUGraph        is repr<CPointer> does GLib::Roles::Pointers is export { }

class DzlGraphLineRenderer is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $.parent;
  HAS GdkRGBA $!stroke-color;
  has gdouble $.line-width    is rw;
  has guint   $.column        is rw;

  method stroke_color is also<stroke-color> is rw {
    Proxy.new:
      FETCH => -> $               { $.stroke-color },

      STORE => -> $, GdkRGBA() $v {
        $!stroke-color.r = $v.r;
        $!stroke-color.g = $v.g;
        $!stroke-color.b = $v.b;
        $!stroke-color.a = $v.a;
      }
  }

  method line_width is rw { $!line-width }
}

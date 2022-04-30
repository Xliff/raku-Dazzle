use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Object;

use GDK::RGBA;

use GLib::Roles::Pointers;

constant dazzle is export = 'dazzle-1.0',v0;

class DzlAnimation          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlApplication        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlApplicationWindow  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBin                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBindingGroup       is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDirectoryModel     is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDock               is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockBin            is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockItem           is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockManager        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockOverlay        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockOverlayEdge    is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphColumn        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphModel         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphView          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphRenderer      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlJoinedMenu         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFlowBox is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuManager        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuButton         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuButtonSection  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockRevealer       is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutChordTable is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSignalGroup        is repr<CPointer> does GLib::Roles::Pointers is export { }

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

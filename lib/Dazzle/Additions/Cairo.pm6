use v6.c;

use NativeCall;

use MONKEY-TYPING;

use Dazzle::Raw::Types;

use Cairo;

use GLib::Roles::Pointers;

role Dazzle::Additions::cairo_t {

  method rounded_rectangle (GdkRectangle $rect, gint $xr, gint $yr)
    is native(dazzle)
    is symbol('dzl_cairo_rounded_rectangle')
  { * }

  method create_region_from_clip_extents
    returns cairo_region_t
    is native(dazzle)
    is symbol('dzl_cairo_region_create_from_clip_extents')
  { * }

}

role Dazzle::Additions::Context {

  method rounded_rectangle (GdkRectangle() $rect, Int() $xr, Int() $yr) {
    my gint ($xxr, $yyr) = ($xr, $yr);

    self.context.rounded_rectangle($rect, $xxr, $yyr);
  }

  method create_region_from_clip_extents {
    self.context.create_region_from_clip_extents
  }

}

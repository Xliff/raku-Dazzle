use v6.c;

use MONKEY-TYPING;

use NativeCall;

use Dazzle::Raw::Types;

use Pango::FontDescription;

augment class Pango::FontDescription {

  method to_css {
    dzl_pango_font_description_to_css(self.PangoFontDescription)
  }

}

sub dzl_pango_font_description_to_css (PangoFontDescription $font_desc)
  returns Str
  is export
  is native(dazzle)
{ * }

use v6.c;

use MONKEY-TYPING;

use NativeCall;

use Dazzle::Raw::Types;

use Pango::FontDescription;

role Dazzle::Additions::FontDescription {

  method font_description_to_css {
    dzl_pango_font_description_to_css(self.PangoFontDescription)
  }

}

sub dzl_pango_font_description_to_css (PangoFontDescription $fd)
  returns Str
  is native(dazzle)
  is export
{ * }

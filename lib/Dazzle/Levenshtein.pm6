use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::StaticClass;

class Dazzle::Levenshtein {
  also does GLib::Roles::StaticClass;

  method compute (Str() $needle, Str() $haystack) {
    dzl_levenshtein($needle, $haystack);
  }

}

sub dzl_levenshtein (Str $needle, Str $haystack)
  returns gint
  is native(dazzle)
  is export
{ * }

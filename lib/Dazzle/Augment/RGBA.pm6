use v6.c;

use MONKEY-TYPING;

use NativeCall;

use Dazzle::Raw::Types;

use GDK::RGBA;

augment class GDK::RGBA {

  multi method shade (Num() $k) {
    my $d = GdkRGBA.new;
    samewith($d, $k);
  }
  multi method shade (GdkRGBA() $dest, Num() $k) {
    dzl_rgba_shade(self, $dest, $k);
    $dest;
  }

}

sub dzl_rgba_shade (GdkRGBA $self, GdkRGBA $dest, gdouble $k)
  is export
  is native(dazzle)
{ * }

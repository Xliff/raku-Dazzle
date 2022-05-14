use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Bin;

our subset DzlCenteringBinAncestry is export of Mu
  where DzlCenteringBin | GtkBinAncestry;

class Dazzle::CenteringBin is GTK::Bin {
  has DzlCenteringBin $!dcb is implementor;

  submethod BUILD ( :$dzl-centering-bin ) {
    self.setDzlCenteringBin($dzl-centering-bin) if $dzl-centering-bin;
  }

  method setDzlCenteringBin (DzlCenteringBinAncestry $_) {
    my $to-parent;

    $!dcb = do {
      when DzlCenteringBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlCenteringBin, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlCenteringBin
    is also<DzlCenteringBin>
  { $!dcb }

  multi method new (DzlCenteringBinAncestry $dzl-centering-bin, :$ref = True) {
    return Nil unless $dzl-centering-bin;

    my $o = self.bless( :$dzl-centering-bin );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-centering-bin = dzl_centering_bin_new();

    $dzl-centering-bin ?? self.bless( :$dzl-centering-bin ) !! Nil;
  }

  # Type: int
  method max-width-request is rw  is g-property is also<max_width_request> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-request', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-request', $gv);
      }
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-centering-bin.h

sub dzl_centering_bin_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

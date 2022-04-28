use v6.c;

use NativeCall;
use Method::Also;

use Dazzle::Raw::Types;

use GTK::Bin;

our subset DzlBinAncestry is export of Mu
  where DzlBin | GtkBinAncestry;

class Dazzle::Bin is GTK::Bin {
  has DzlBin $!db is implementor;

  submethod BUILD( :$dzl-bin ) {
    self.setDzlDockOverlay($dzl-bin) if $dzl-bin;
  }

  method setDzlDockOverlay (DzlBinAncestry $_) {
    my $to-parent;

    $!db = do {
      when DzlBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlBin, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method GTK::Raw::Definitions::DzlBin
    is also<DzlBin>
  { $!db }

  multi method new (DzlBinAncestry $dzl-bin, :$ref = True) {
    return Nil unless $dzl-bin;

    my $o = self.bless( :$dzl-bin );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-bin = dzl_bin_new();

    $dzl-bin ?? self.bless( :$dzl-bin ) !! Nil;
  }

}


### /usr/src/libdazzle-3.42.0/src/widgets/dzl-bin.h

sub dzl_bin_new ()
  returns DzlBin
  is native(dazzle)
  is export
{ * }

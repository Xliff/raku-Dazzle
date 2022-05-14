use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Box;

our subset DzlEntryBoxAncestry is export of Mu
  where DzlEntryBox | GtkBoxAncestry;

class Dazzle::EntryBox is GTK::Box {
  has DzlEntryBox $!deb is implementor;

  submethod BUILD ( :$dzl-entry-box ) {
    self.setDzlEntryBox($dzl-entry-box) if $dzl-entry-box;
  }

  method setDzlEntryBox(DzlEntryBoxAncestry $_) {
    my $to-parent;

    $!deb = do {
      when DzlEntryBox {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlEntryBox, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlEntryBox
  { $!deb }

  multi method new (DzlEntryBoxAncestry $dzl-entry-box, :$ref = True) {
    return unless $dzl-entry-box;

    my $o = self.bless( :$dzl-entry-box );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-entry-box = dzl_entry_box_new();

    $dzl-entry-box ?? self.bless( :$dzl-entry-box ) !! Nil
  }

  # Type: int
  method max-width-chars is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

}


### /usr/src/libdazzle-3.42.0/src/widgets/dzl-entry-box.h

sub dzl_entry_box_new ()
  returns DzlEntryBox
  is native(dazzle)
  is export
{ * }

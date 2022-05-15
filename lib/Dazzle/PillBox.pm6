use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::EventBox;

our subset DzlPillBoxAncestry is export of Mu
  where DzlPillBox | GtkEventBoxAncestry;

class Dazzle::PillBox is GTK::EventBox {
  has DzlPillBox $!dpb is implementor;

  submethod BUILD ( :$dzl-pill-box ) {
    self.setDzlPillBox($dzl-pill-box) if $dzl-pill-box;
  }

  method setDzlPillBox (DzlPillBoxAncestry $_) {
    my $to-parent;

    $!dpb = do {
      when DzlPillBox  {
        $to-parent = cast(GtkEventBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPillBox, $_);
      }
    }
    self.setGtkEventBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPillBox
    is also<DzlPillBox>
  { $!dpb }

  multi method new (DzlPillBoxAncestry $dzl-pill-box, :$ref = True) {
    return Nil unless $dzl-pill-box;

    my $o = self.bless( :$dzl-pill-box );
    $o.ref if $ref;
    $o
  }
  multi method new (Str() $label) {
    my $dzl-pill-box = dzl_pill_box_new($label);

    $dzl-pill-box ?? self.bless( :$dzl-pill-box ) !! Nil;
  }

  # Type: string
  method label is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('label', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  method get_label is also<get-label> {
    dzl_pill_box_get_label($!dpb);
  }

  method set_label (Str() $label) is also<set-label> {
    dzl_pill_box_set_label($!dpb, $label);
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-pill-box.h

sub dzl_pill_box_get_label (DzlPillBox $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_pill_box_new (Str $label)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_pill_box_set_label (DzlPillBox $self, Str $label)
  is native(dazzle)
  is export
{ * }

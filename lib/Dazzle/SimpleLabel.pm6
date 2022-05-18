use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::SimpleLabel;

use GLib::Value;
use GTK::Label;

our subset DzlSimpleLabelAncestry is export of Mu
  where DzlSimpleLabel | GtkLabelAncestry;

class Dazzle::SimpleLabel is GTK::Label {
  has DzlSimpleLabel $!dsl is implementor;

  submethod BUILD ( :$dzl-simple-label ) {
    self.setDzlSimpleLabel($dzl-simple-label) if $dzl-simple-label;
  }

  method setDzlSimpleLabel (DzlSimpleLabelAncestry $_) {
    my $to-parent;

    $!dsl = do {
      when DzlSimpleLabel  {
        $to-parent = cast(GtkLabel, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSimpleLabel, $_);
      }
    }
    self.setGtkLabel($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSimpleLabel
    is also<DzlSimpleLabel>
  { $!dsl }

  proto method new (|)
  { * }

  multi method new (DzlSimpleLabelAncestry $dzl-simple-label, :$ref = True) {
    return Nil unless $dzl-simple-label;

    my $o = self.bless( :$dzl-simple-label );
    $o.ref if $ref;
    $o
  }
  multi method new (Str() $label = Str) is default {
    my $dzl-simple-label = dzl_simple_label_new($label);

    $dzl-simple-label ?? self.bless( :$dzl-simple-label ) !! Nil;
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

  # Type: int
  method width-chars is rw is g-property is also<width_chars> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-chars', $gv);
      }
    );
  }

  # Type: float
  method xalign is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('xalign', $gv);
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  method get_label is also<get-label> {
    dzl_simple_label_get_label($!dsl);
  }

  method get_width_chars is also<get-width-chars> {
    dzl_simple_label_get_width_chars($!dsl);
  }

  method get_xalign is also<get-xalign> {
    dzl_simple_label_get_xalign($!dsl);
  }

  method set_label (Str() $label) is also<set-label> {
    dzl_simple_label_set_label($!dsl, $label);
  }

  method set_width_chars (Int() $width_chars) is also<set-width-chars> {
    my gint $w = $width_chars;

    dzl_simple_label_set_width_chars($!dsl, $w);
  }

  method set_xalign (Num() $xalign) is also<set-xalign> {
    my gfloat $x = $xalign;

    dzl_simple_label_set_xalign($!dsl, $x);
  }

}

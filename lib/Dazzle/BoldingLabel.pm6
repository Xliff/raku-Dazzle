use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Label;

our subset DzlBoldingLabelAncestry is export of Mu
  where DzlBoldingLabel | GtkLabelAncestry;

class Dazzle::BoldingLabel is GTK::Label {
  has DzlBoldingLabel $!dbl is implementor;

  submethod BUILD ( :$dzl-bolding-label ) {
    self.setDzlBoldingLabel($dzl-bolding-label) if $dzl-bolding-label;
  }

  method setDzlBoldingLabel (DzlBoldingLabelAncestry $_) {
    my $to-parent;

    $!dbl = do {
      when DzlBoldingLabel {
        $to-parent = cast(GtkLabel, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlBoldingLabel, $_);
      }
    }
    self.setGtkLabel($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlBoldingLabel
  { $!dbl }

  multi method new (DzlBoldingLabelAncestry $dzl-bolding-label, :$ref = True) {
    return Nil unless $dzl-bolding-label;

    my $o = self.bless( :$dzl-bolding-label );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $label, Int() $bold) {
    my gboolean $b = $bold.so.Int;

    dzl_bolding_label_new($label, $b);
  }

  method new_with_mnemonic (Str $str, Int() $bold) {
    my gboolean $b = $bold.so.Int;

    dzl_bolding_label_new_with_mnemonic($str, $b);
  }

  method set_bold (Int() $bold) {
    my gboolean $b = $bold.so.Int;

    dzl_bolding_label_set_bold($!dbl, $b);
  }

  method set_weight (Int() $weight) {
    my PangoWeight $w = $weight;

    dzl_bolding_label_set_weight($!dbl, $w);
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-bolding-label.h

sub dzl_bolding_label_new (Str $str, gboolean $bold)
  returns DzlBoldingLabel
  is native(dazzle)
  is export
{ * }

sub dzl_bolding_label_new_with_mnemonic (Str $str, gboolean $bold)
  returns DzlBoldingLabel
  is native(dazzle)
  is export
{ * }

sub dzl_bolding_label_set_bold (DzlBoldingLabel $self, gboolean $bold)
  is native(dazzle)
  is export
{ * }

sub dzl_bolding_label_set_weight (DzlBoldingLabel $self, PangoWeight $weight)
  is native(dazzle)
  is export
{ * }

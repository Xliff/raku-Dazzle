use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Box;
use Dazzle::Shortcut::Chord;

our subset DzlShortcutLabelAncestry is export of Mu
  where DzlShortcutLabel | GtkBoxAncestry;

class Dazzle::Shortcut::Label is GTK::Box {
  has DzlShortcutLabel $!dsl is implementor;

  submethod BUILD ( :$dzl-shortcut-label ) {
    self.setDzlShortcutLabel($dzl-shortcut-label) if $dzl-shortcut-label;
  }

  method setDzlShortcutLabel(DzlShortcutLabelAncestry $_) {
    my $to-parent;

    $!dsl = do {
      when DzlShortcutLabel {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutLabel, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutLabel
  { $!dsl }

  multi method new (DzlShortcutLabelAncestry $dzl-shortcut-label, :$ref = True) {
    return unless $dzl-shortcut-label;

    my $o = self.bless( :$dzl-shortcut-label );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-shortcut-label = dzl_shortcut_label_new();

    $dzl-shortcut-label ?? self.bless( :$dzl-shortcut-label ) !! Nil;
  }

  # Type: string
  method accelerator is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accelerator', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accelerator', $gv);
      }
    );
  }

  # Type: DzlShortcutChord
  method chord ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( Dazzle::Shortcut::Chord.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('chord', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Shortcut::Chord.getTypePair
        );
      },
      STORE => -> $, DzlShortcutChord() $val is copy {
        $gv.object = $val;
        self.prop_set('chord', $gv);
      }
    );
  }

  method get_accelerator {
    dzl_shortcut_label_get_accelerator($!dsl);
  }

  method get_chord ( :$raw = False ) {
    propReturnObject(
      dzl_shortcut_label_get_chord($!dsl),
      $raw,
      |Dazzle::Shortcut::Chord.getTypePair
    );
  }

  method set_accelerator (Str() $accelerator) {
    dzl_shortcut_label_set_accelerator($!dsl, $accelerator);
  }

  method set_chord (DzlShortcutChord() $chord) {
    dzl_shortcut_label_set_chord($!dsl, $chord);
  }

}

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-label.h

sub dzl_shortcut_label_get_accelerator (DzlShortcutLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_label_get_chord (DzlShortcutLabel $self)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_label_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_label_set_accelerator (DzlShortcutLabel $self, Str $accelerator)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_label_set_chord (DzlShortcutLabel $self, DzlShortcutChord $chord)
  is native(dazzle)
  is export
{ * }

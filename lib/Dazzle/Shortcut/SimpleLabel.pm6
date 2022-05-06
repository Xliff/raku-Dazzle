use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::SimpleLabel;

use GTK::Box;

our subset DzlShortcutSimpleLabelAncestry is export of Mu
  where DzlShortcutSimpleLabel | GtkBoxAncestry;

class Dazzle::Shortcut::Simple::Label is GTK::Box {
  has DzlShortcutSimpleLabel $!dssl is implementor;

  submethod BUILD ( :$dzl-shortcut-simple-label ) {
    self.setDzlShortcutSimpleLabel($dzl-shortcut-simple-label)
      if $dzl-shortcut-simple-label;
  }

  method setDzlShortcutSimpleLabel(DzlShortcutSimpleLabelAncestry $_) {
    my $to-parent;

    $!dssl = do {
      when DzlShortcutSimpleLabel {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutSimpleLabel, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutSimpleLabel
  { $!dssl }

  multi method new (
    DzlShortcutSimpleLabelAncestry  $dzl-shortcut-simple-label,
                              :$ref                  = True
  ) {
    return unless $dzl-shortcut-simple-label;

    my $o = self.bless( :$dzl-shortcut-simple-label );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-shortcut-simple-label = dzl_shortcut_simple_label_new();

    $dzl-shortcut-simple-label ?? self.bless( :$dzl-shortcut-simple-label )
                               !! Nil
  }

  # Type: string
  method accel is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('accel', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('accel', $gv);
      }
    );
  }

  # Type: string
  method action is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('action', $gv);
      }
    );
  }

  # Type: string
  method command is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('command', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('command', $gv);
      }
    );
  }

  # Type: boolean
  method show-accel is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-accel', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-accel', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method get_accel {
    dzl_shortcut_simple_label_get_accel($!dssl);
  }

  method get_action {
    dzl_shortcut_simple_label_get_action($!dssl);
  }

  method get_command {
    dzl_shortcut_simple_label_get_command($!dssl);
  }

  method get_title {
    dzl_shortcut_simple_label_get_title($!dssl);
  }

  method set_accel (Str() $accel) {
    dzl_shortcut_simple_label_set_accel($!dssl, $accel);
  }

  method set_action (Str() $action) {
    dzl_shortcut_simple_label_set_action($!dssl, $action);
  }

  method set_command (Str() $command) {
    dzl_shortcut_simple_label_set_command($!dssl, $command);
  }

  method set_title (Str() $title) {
    dzl_shortcut_simple_label_set_title($!dssl, $title);
  }

}

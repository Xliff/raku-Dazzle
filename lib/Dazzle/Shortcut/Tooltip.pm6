use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Tooltip;

use GLib::Value;
use GTK::Widget;

use GLib::Roles::Object;

our subset DzlShortcutTooltipAncestry is export of Mu
  where DzlShortcutTooltip | GObject;

class Dazzle::Shortcut::Tooltip {
  also does GLib::Roles::Object;

  has DzlShortcutTooltip is implementor;

  submethod BUILD (:$dzl-shortcut-tooltip) {
    self.setDzlShortcutTooltip($dzl-shortcut-tooltip) if $dzl-shortcut-tooltip;
  }

  method setDzlShortcutTooltip (DzlShortcutTooltipAncestry $_) {
    my $to-parent;

    $!dst = do {
      when DzlShortcutTooltip {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutTooltip, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutTooltip
    is also<DzlShortcutTooltip>
  { $!dst }

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
  method command-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('command-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('command-id', $gv);
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

  # Type: GtkWidget
  method widget ( :$raw = False, $widget = False ) is rw is g-property {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('widget', $gv);

        ReturnWidget(
          $gv.object,
          $raw,
          $widget
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('widget', $gv);
      }
    );
  }

  multi method new (
    DzlShortcutTooltipAncestry  $dzl-shortcut-tooltip,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-shortcut-tooltip;

    my $o = self.bless( :$dzl-shortcut-tooltip );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-shortcut-tooltip = dzl_shortcut_tooltip_new();

    $dzl-shortcut-tooltip ?? self.bless( :$dzl-shortcut-tooltip )
                          !! Nil;
  }

  method get_accel {
    dzl_shortcut_tooltip_get_accel($!dst);
  }

  method get_command_id {
    dzl_shortcut_tooltip_get_command_id($!dst);
  }

  method get_title {
    dzl_shortcut_tooltip_get_title($!dst);
  }

  method get_widget ( :$raw = False, :$widget = False ) {
    ReturnWidget(
      dzl_shortcut_tooltip_get_widget($!dst),
      $raw,
      $widget
    );
  }

  method set_accel (Str() $accel) {
    dzl_shortcut_tooltip_set_accel($!dst, $accel);
  }

  method set_command_id (Str() $command_id) {
    dzl_shortcut_tooltip_set_command_id($!dst, $command_id);
  }

  method set_title (Str() $title) {
    dzl_shortcut_tooltip_set_title($!dst, $title);
  }

  method set_widget (GtkWidget() $widget) {
    dzl_shortcut_tooltip_set_widget($!dst, $widget);
  }

}

use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::TabStrip;

use GTK::Box;

our subset DzlTabStripAncestry is export of Mu
  where DzlTabStrip | GtkBoxAncestry;

class Dazzle::TabStrip is GTK::Box {
  has DzlTabStrip $!dts is implementor;

  submethod BUILD ( :$dzl-tab-strip ) {
    self.setDzlTabStrip($dzl-tab-strip) if $dzl-tab-strip;
  }

  method setDzlTabStrip(DzlTabStripAncestry $_) {
    my $to-parent;

    $!dts = do {
      when DzlTabStrip {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlTabStrip, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlTabStrip
  { $!dts }

  multi method new (DzlTabStripAncestry $dzl-tab-strip, :$ref = True) {
    return unless $dzl-tab-strip;

    my $o = self.bless( :$dzl-tab-strip );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-tab-strip = dzl_tab_strip_new();
  }

  # Type: GtkPositionType
  method edge is rw  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkPositionType) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'edge does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('edge', $gv);
      }
    );
  }

  # Type: GtkStack
  method stack is rw  {
    my $gv = GLib::Value.new( GTK::Stack.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'stack does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkStack() $val is copy {
        $gv.object = $val;
        self.prop_set('stack', $gv);
      }
    );
  }

  # Type: DzlTabStyle
  method style is rw  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(DzlTabStyle) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'style does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(DzlTabStyle) = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  method add_control (GtkWidget() $widget) {
    dzl_tab_strip_add_control($!dts, $widget);
  }

  method get_edge {
    GtkPositionTypeEnum( dzl_tab_strip_get_edge($!dts) );
  }

  method get_stack ( :$raw = False ) {
    propReturnObject(
      dzl_tab_strip_get_stack($!dts),
      $raw,
      |GTK::Stack.getTypePair
    );
  }

  method get_style {
    DzlTabStyleEnum( dzl_tab_strip_get_style($!dts) );
  }

  method set_edge (Int() $edge) {
    my GtkPositionType $e = $edge;

    dzl_tab_strip_set_edge($!dts, $edge);
  }

  method set_stack (GtkStack() $stack) {
    dzl_tab_strip_set_stack($!dts, $stack);
  }

  method set_style (DzlTabStyle $style) {
    dzl_tab_strip_set_style($!dts, $style);
  }

}

use v6.c;

use Method::Also;

use Dazzle::Raw::Types;
use Dazzle::Raw::Tab;

use GLib::Value;
use GTK::Widget;
use Dazzle::Bin;

use GLib::Roles::Signals::Generic;
use GTK::Roles::Actionable;

our subset DzlTabAncestry is export of Mu
  where DzlTab | GtkActionable | DzlBinAncestry;

class Dazzle::Tab is Dazzle::Bin {
  also does GLib::Roles::Signals::Generic;
  also does GTK::Roles::Actionable;

  has DzlTab $!dt is implementor;

  submethod BUILD ( :$dzl-tab ) {
    self.setDzlTab($dzl-tab) if $dzl-tab;
  }

  method setDzlTab (DzlTabAncestry $_) {
    my $to-parent;

    $!dt = do {
      when DzlTab {
        $to-parent = cast(DzlBin, $_);
        $_;
      }

      when GtkActionable {
        $to-parent = cast(DzlBin, $_);
        $!action   = $_;
        cast(DzlTab, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlTab, $_);
      }
    }
    self.setDzlBin($to-parent);
    self.roleInit-GtkActionable;
  }

  method Dazzle::Raw::Definitions::DzlTab
    is also<DzlTab>
  { $!dt }

  multi method new (DzlTabAncestry $dzl-tab, :$ref = True) {
    return Nil unless $dzl-tab;

    my $o = self.bless( :$dzl-tab );
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method active is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'active does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('active', $gv);
      }
    );
  }

  # Type: boolean
  method can-close is rw  is also<can_close> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'can-close does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('can-close', $gv);
      }
    );
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

  # Type: string
  method title is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'title does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: GtkWidget
  method widget is rw  {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'widget does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('widget', $gv);
      }
    );
  }

  method clicked {
    self.connect($!dt, 'clicked');
  }

  method get_active is also<get-active> {
    so dzl_tab_get_active($!dt);
  }

  method get_can_close is also<get-can-close> {
    so dzl_tab_get_can_close($!dt);
  }

  method get_edge is also<get-edge> {
    GtkPositionTypeEnum( dzl_tab_get_edge($!dt) );
  }

  method get_icon_name is also<get-icon-name> {
    dzl_tab_get_icon_name($!dt);
  }

  method get_style is also<get-style> {
    DzlTabStyle( dzl_tab_get_style($!dt) );
  }

  method get_title is also<get-title> {
    dzl_tab_get_title($!dt);
  }

  method get_widget ( :$raw = False, :$widget = False ) is also<get-widget> {
    ReturnWidget(
      dzl_tab_get_widget($!dt),
      $raw,
      $widget
    );
  }

  method set_active (Int() $active) is also<set-active> {
    my gboolean $a = $active;

    dzl_tab_set_active($!dt, $active);
  }

  method set_can_close (Int() $can_close) is also<set-can-close> {
    my gboolean $c = $can_close.so.Int;

    dzl_tab_set_can_close($!dt, $can_close);
  }

  method set_edge (Int() $edge) is also<set-edge> {
    my GtkPositionType $e = $edge;

    dzl_tab_set_edge($!dt, $edge);
  }

  method set_gicon (GIcon() $gicon) is also<set-gicon> {
    dzl_tab_set_gicon($!dt, $gicon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    dzl_tab_set_icon_name($!dt, $icon_name);
  }

  method set_style (Int() $style) is also<set-style> {
    my DzlTabStyle $s = $style;

    dzl_tab_set_style($!dt, $style);
  }

  method set_title (Str $title) is also<set-title> {
    dzl_tab_set_title($!dt, $title);
  }

  method set_widget (GtkWidget() $widget) is also<set-widget> {
    dzl_tab_set_widget($!dt, $widget);
  }

}

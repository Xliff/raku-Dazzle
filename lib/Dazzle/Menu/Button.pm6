use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Menu::Button;

use GTK::MenuButton;

our subset DzlMenuButtonAncestry is export of Mu
  where DzlMenuButton | GtkMenuButtonAncestry;

class Dazzle::Menu::Button is GTK::MenuButton {
  has DzlMenuButton $!dmb is implementor;

  submethod BUILD ( :$dzl-menu-button ) {
    self.setDzlMenuButton($dzl-menu-button) if $dzl-menu-button
  }

  method setDzlMenuButton (DzlMenuButtonAncestry $_) {
    my $to-parent;

    $!dmb = do {
      when DzlMenuButton {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlMenuButton, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlMenuButton
  { $!dmb }

  multi method new (DzlMenuButtonAncestry  $dzl-menu-button, :$ref = True) {
    return Nil unless $dzl-menu-button;

    my $o = self.bless( :$dzl-menu-button );
    $o.ref if $ref;
    $o
  }
  multi method new_with_model (Str() $icon_name, GMenuModel() $model) {
    my $dzl-menu-button = dzl_menu_button_new_with_model($icon_name, $model);

    $dzl-menu-button ?? self.bless( :$dzl-menu-button ) !! Nil;
  }

  # Type: string
  method icon-name is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'icon-name does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: string
  method menu-id is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'menu-id does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('menu-id', $gv);
      }
    );
  }

  # Type: GMenuModel
  method model is rw  {
    my $gv = GLib::Value.new( GIO::MenuModel );
    Proxy.new(
      FETCH => sub ($) {
        warn 'model does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method show-accels is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-accels does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-accels', $gv);
      }
    );
  }

  # Type: boolean
  method show-arrow is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-arrow does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-arrow', $gv);
      }
    );
  }

  # Type: boolean
  method show-icons is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-icons does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-icons', $gv);
      }
    );
  }

  # Type: boolean
  method transitions-enabled is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'transitions-enabled does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('transitions-enabled', $gv);
      }
    );
  }

  method get_model ( :$raw = False ) {
    propReturnObject(
      dzl_menu_button_get_model($!dmb),
      $raw,
      |GIO::MenuModel.getTypePair
    );
  }

  method get_show_accels {
    so dzl_menu_button_get_show_accels($!dmb);
  }

  method get_show_arrow {
    so dzl_menu_button_get_show_arrow($!dmb);
  }

  method get_show_icons {
    so dzl_menu_button_get_show_icons($!dmb);
  }

  method set_model (GMenuModel() $model) {
    dzl_menu_button_set_model($!dmb, $model);
  }

  method set_show_accels (Int() $show_accels) {
    my gboolean $s = $show_accels.so.Int;

    dzl_menu_button_set_show_accels($!dmb, $s);
  }

  method set_show_arrow (Int() $show_arrow) {
    my gboolean $s = $show_arrow.so.Int;

    dzl_menu_button_set_show_arrow($!dmb, $s);
  }

  method set_show_icons (Int() $show_icons) {
    my gboolean $s = $show_icons.so.Int;

    dzl_menu_button_set_show_icons($!dmb, $s);
  }

}

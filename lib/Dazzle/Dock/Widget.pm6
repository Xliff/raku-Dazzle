use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use Dazzle::Bin;

use Dazzle::Roles::Dock::Item;

class Dazzle::Dock::Widget is Dazzle::Bin {
  also does Dazzle::Roles::Dock::Item;

  has DzlDockWidget $!ddw;

  method new {
    my $dzl-dock-widget = dzl_dock_widget_new();

    $dzl-dock-widget ?? self.bless( :$dzl-dock-widget ) !! Nil;
  }

  # Type: boolean
  method can-close is rw  {
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

  # Type: GIcon
  method gicon is rw  {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'gicon does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('gicon', $gv);
      }
    );
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

  # Type: DzlDockManager
  method manager is rw  {
    my $gv = GLib::Value.new( Dazzle::Dock::Manager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'manager does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, DzlDockManager() $val is copy {
        $gv.object = $val;
        self.prop_set('manager', $gv);
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

  method set_gicon (GIcon() $gicon) {
    dzl_dock_widget_set_gicon($!ddw, $gicon);
  }

  method set_icon_name (Str() $icon_name) {
    dzl_dock_widget_set_icon_name($!ddw, $icon_name);
  }

  method set_title (Str() $title) {
    dzl_dock_widget_set_title($!ddw, $title);
  }

}


### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-widget.h

sub dzl_dock_widget_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_widget_set_gicon (DzlDockWidget $self, GIcon $gicon)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_widget_set_icon_name (DzlDockWidget $self, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_widget_set_title (DzlDockWidget $self, Str $title)
  is native(dazzle)
  is export
{ * }

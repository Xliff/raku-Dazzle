use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::Bin;

use GTK::Container;
use GTK::Widget;

use Dazzle::Roles::Dock::Item;

our subset DzlDockBinAncestry is export of Mu
  where DzlDockBin | DzlDockItem | DzlDock | GtkContainerAncestry;

class Dazzle::Dock::Bin is GTK::Container {
  also does Dazzle::Roles::Dock::Item;

  has DzlDockBin $!ddb is implementor;

  submethod BUILD ( :$dzl-dock-bin ) {
    self.setDzlDockBin($dzl-dock-bin) if $dzl-dock-bin;
  }

  method setDzlDockBin(DzlDockBinAncestry $_) {
    my $to-parent;
    $!ddb = do {
      when DzlDockBin {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      when DzlDockItem {
        $to-parent = cast(GtkContainer, $_);
        $!ddi      = $_;
        cast(DzlDockBin, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlDockBin, $_);
      }
    }
    self.setGtkContainer($to-parent);
    self.roleInit-DzlDockItem;
  }

  method Dazzle::Raw::Definitions::DzlDockBin
  { $!ddb }

  multi method new (DzlDockBinAncestry $dzl-dock-bin, :$ref = True) {
    return unless $dzl-dock-bin;

    my $o = self.bless( :$dzl-dock-bin );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-bin = dzl_dock_bin_new();

    $dzl-dock-bin ?? self.bless( :$dzl-dock-bin ) !! Nil;
  }

  # Type: boolean
  method bottom-visible is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'bottom-visible does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('bottom-visible', $gv);
      }
    );
  }

  # Type: boolean
  method left-visible is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'left-visible does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('left-visible', $gv);
      }
    );
  }

  # Type: boolean
  method pinned is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'pinned does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('pinned', $gv);
      }
    );
  }

  # Type: GtkPositionType
  method position is rw  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkPositionType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('position', $gv);
        GtkPositionTypeEnum( $gv.value )
      },
      STORE => -> $, $val is copy {
        warn 'position does not allow writing'
      }
    );
  }

  # Type: int
  method priority is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'priority does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('priority', $gv);
      }
    );
  }

  # Type: boolean
  method right-visible is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'right-visible does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('right-visible', $gv);
      }
    );
  }

  # Type: boolean
  method top-visible is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'top-visible does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('top-visible', $gv);
      }
    );
  }

  method get_bottom_edge ( :$raw = False, :$widget = False ) {
    ReturnWidget( dzl_dock_bin_get_bottom_edge($!ddb), $raw, $widget) ;
  }

  method get_center_widget ( :$raw = False, :$widget = False ) {
    ReturnWidget( dzl_dock_bin_get_center_widget($!ddb), $raw, $widget) ;
  }

  method get_left_edge ( :$raw = False, :$widget = False ) {
    ReturnWidget( dzl_dock_bin_get_left_edge($!ddb), $raw, $widget) ;
  }

  method get_right_edge ( :$raw = False, :$widget = False ) {
    ReturnWidget( dzl_dock_bin_get_right_edge($!ddb), $raw, $widget) ;
  }

  method get_top_edge ( :$raw = False, :$widget = False ) {
    ReturnWidget( dzl_dock_bin_get_top_edge($!ddb), $raw, $widget) ;
  }

}

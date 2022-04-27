use v6.c;

use Dazzle::Raw::Types;

use GTK::EventBox;

use GLib::Roles::Signals::Generic;

class Dazzle::Dock::Overlay is GTK::EventBox {
  also does GLib::Roles::Signals::Generic;

  has DzlDockOverlay $!ddo;

  submethod BUILD( :$dzl-dock-overlay ) {
    self.setDzlDockOverlay($dzl-dock-overlay) if $dzl-dock-overlay;
  }

  method setDzlDockOverlay (DzlDockOverlayAncestry $_) {
    my $to-parent;

    $!ddo = do {
      when DzlDockOverlay  {
        $to-parent = cast(GtkEventBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockOverlay, $_);
      }
    }
    self.setGtkEventBox($to-parent);
    self.roleInit-HdySwipeable;
  }

  method GTK::Raw::Definitions::DzlDockOverlay
    is also<DzlDockOverlay>
  { $!ddo }

  multi method new (DzlDockOverlayAncestry $dzl-dock-overlay, :$ref = True) {
    return Nil unless $dzl-dock-overlay;

    my $o = self.bless( :$dzl-dock-overlay );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-overlay = dzl_dock_overlay_new();

    $dzl-dock-overlay ?? self.bless( :$dzl-dock-overlay ) !! Nil;
  }

  # Type: boolean
  method reveal is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'reveal does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reveal', $gv);
      }
    );
  }

  method hide-edges {
    self.connect($!ddo, 'hide-edges');
  }

  # Type: boolean
  method revealed is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('revealed', $gv)
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'revealed does not allow writing'
      }
    );
  }

  method add_child (GtkWidget() $child, Str() $type) {
    dzl_overlay_add_child($!ddo, $child, $type);
  }

  method get_edge (Int() $position, :$raw = False) {
    my GtkPositionType $p = $position;

    propReturnObject(
      dzl_dock_overlay_get_edge($!ddo, $p),
      $raw,
      |Dazzle::Dock::Overlay::Edge.getTypePair
    )
  }

  method get_edge_adjustment (Int() $position, :$raw = False) {
    my GtkPositionType $p = $position;

    propReturnObject(
      dzl_dock_overlay_get_edge_adjustment($!ddo, $position),
      $raw,
      |GTK::Adjustment.getTypePair
    );

  }

}

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-overlay.h

sub dzl_overlay_add_child (
  DzlDockOverlay $self,
  GtkWidget      $child,
  Str            $type
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_get_edge (DzlDockOverlay $self, GtkPositionType $position)
  returns DzlDockOverlayEdge
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_get_edge_adjustment (
  DzlDockOverlay  $self,
  GtkPositionType $position
)
  returns GtkAdjustment
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use Dazzle::Bin;

our subset DzlDockOverlayEdgeAncestry is export of Mu
  where DzlDockOverlayEdge | GtkEventBoxAncestry;

class Dazzle::Panel::Overlay::Edge is Dazzle::Bin {
  has DzlPanelOverlayEdge $!ddoe;

  submethod BUILD( :$dzl-dock-overlay-edge ) {
    self.setDzlDockOverlay($dzl-dock-overlay-edge) if $dzl-dock-overlay-edge;
  }

  method setDzlDockOverlay (DzlDockOverlayEDgeAncestry $_) {
    my $to-parent;

    $!ddo = do {
      when DzlDockOverlayEdge  {
        $to-parent = cast(DzlBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockOverlayEdge, $_);
      }
    }
    self.setGtkEventBox($to-parent);
    self.roleInit-HdySwipeable;
  }

  method GTK::Raw::Definitions::DzlDockOverlayEdge
    is also<DzlDockOverlayEdge>
  { $!ddo }

  multi method new (
    DzlDockOverlayEdgeAncestry  $dzl-dock-overlay-edge,
                               :$ref                     = True
  ) {
    return Nil unless $dzl-dock-overlay-edge;

    my $o = self.bless( :$dzl-dock-overlay-edge );
    $o.ref if $ref;
    $o;
  }

  method get_edge {
    GtkPositionTypeEnum( dzl_dock_overlay_edge_get_edge($!ddoe) )
  }

  method get_position {
    dzl_dock_overlay_edge_get_position($!ddoe);
  }

  method set_edge (Int() $edge) {
    my GtkPositionType $e = $edge;

    dzl_dock_overlay_edge_set_edge($!ddoe, $e);
  }

  method set_position (Int() $position) {
    my gint $p = $position;

    dzl_dock_overlay_edge_set_position($!ddoe, $p);
  }

}


### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-overlay-edge.h

sub dzl_dock_overlay_edge_get_edge (DzlDockOverlayEdge $self)
  returns GtkPositionType
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_edge_get_position (DzlDockOverlayEdge $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_edge_set_edge (
  DzlDockOverlayEdge $self,
  GtkPositionType    $edge
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_overlay_edge_set_position (
  DzlDockOverlayEdge $self,
  gint               $position
)
  is native(dazzle)
  is export
{ * }

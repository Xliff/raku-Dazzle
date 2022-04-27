use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Dock::Bin;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-bin.h

sub dzl_dock_bin_get_bottom_edge (DzlDockBin $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_bin_get_center_widget (DzlDockBin $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_bin_get_left_edge (DzlDockBin $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_bin_get_right_edge (DzlDockBin $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_bin_get_top_edge (DzlDockBin $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_bin_new ()
  returns DzlDockBin
  is native(dazzle)
  is export
{ * }

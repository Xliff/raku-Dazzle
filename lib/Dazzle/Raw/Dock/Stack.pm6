use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Dock::Stack;


### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-stack.h

sub dzl_dock_stack_get_edge (DzlDockStack $self)
  returns GtkPositionType
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_get_show_pinned_button (DzlDockStack $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_get_style (DzlDockStack $self)
  returns DzlTabStyle
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_set_edge (
  DzlDockStack    $self,
  GtkPositionType $edge
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_set_show_pinned_button (
  DzlDockStack $self,
  gboolean     $show_pinned_button
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_stack_set_style (
  DzlDockStack $self,
  DzlTabStyle  $style
)
  is native(dazzle)
  is export
{ * }

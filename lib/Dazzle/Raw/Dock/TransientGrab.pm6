use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Dock::Transient::Grab;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-transient-grab.h

sub dzl_dock_transient_grab_acquire (DzlDockTransientGrab $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_add_item (
  DzlDockTransientGrab $self,
  DzlDockItem          $item
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_cancel (DzlDockTransientGrab $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_contains (
  DzlDockTransientGrab $self,
  DzlDockItem          $item
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_get_timeout (DzlDockTransientGrab $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_is_descendant (
  DzlDockTransientGrab $self,
  GtkWidget            $widget
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_new ()
  returns DzlDockTransientGrab
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_release (DzlDockTransientGrab $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_remove_item (
  DzlDockTransientGrab $self,
  DzlDockItem          $item
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_set_timeout (
  DzlDockTransientGrab $self,
  guint                $timeout
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_transient_grab_steal_common_ancestors (
  DzlDockTransientGrab $self,
  DzlDockTransientGrab $other
)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Dock::Item;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-item.h

sub _dzl_dock_item_printf (DzlDockItem $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_adopt (DzlDockItem $self, DzlDockItem $child)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_close (DzlDockItem $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_emit_presented (DzlDockItem $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_can_close (DzlDockItem $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_can_minimize (DzlDockItem $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_child_visible (DzlDockItem $self, DzlDockItem $child)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_icon_name (DzlDockItem $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_manager (DzlDockItem $self)
  returns DzlDockManager
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_parent (DzlDockItem $self)
  returns DzlDockItem
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_get_title (DzlDockItem $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_has_widgets (DzlDockItem $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_minimize (
  DzlDockItem     $self,
  DzlDockItem     $child,
  GtkPositionType $position
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_needs_attention (DzlDockItem $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_present (DzlDockItem $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_present_child (DzlDockItem $self, DzlDockItem $child)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_ref_gicon (DzlDockItem $self)
  returns GIcon
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_release (DzlDockItem $self, DzlDockItem $child)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_set_child_visible (
  DzlDockItem $self,
  DzlDockItem $child,
  gboolean    $child_visible
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_set_manager (DzlDockItem $self, DzlDockManager $manager)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_item_update_visibility (DzlDockItem $self)
  is native(dazzle)
  is export
{ * }

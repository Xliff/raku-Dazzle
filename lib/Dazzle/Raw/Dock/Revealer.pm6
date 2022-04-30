use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Dock::Revealer;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-revealer.h

sub dzl_dock_revealer_animate_to_position (
  DzlDockRevealer $self,
  gint            $position,
  guint           $transition_duration
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_child_revealed (DzlDockRevealer $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_position (DzlDockRevealer $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_position_set (DzlDockRevealer $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_reveal_child (DzlDockRevealer $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_transition_duration (DzlDockRevealer $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_get_transition_type (DzlDockRevealer $self)
  returns DzlDockRevealerTransitionType
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_is_animating (DzlDockRevealer $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_set_position (DzlDockRevealer $self, gint $position)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_set_position_set (
  DzlDockRevealer $self,
  gboolean        $position_set
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_set_reveal_child (
  DzlDockRevealer $self,
  gboolean        $reveal_child
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_set_transition_duration (
  DzlDockRevealer $self,
  guint           $transition_duration
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_set_transition_type (
  DzlDockRevealer               $self,
  DzlDockRevealerTransitionType $transition_type
)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_revealer_transition_type_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

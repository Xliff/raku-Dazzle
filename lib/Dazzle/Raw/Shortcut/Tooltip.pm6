use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Raw::Definitions;
use Dazzle::Raw::Types;

unit package Dazzle::Raw::Shortcut::Tooltip;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-tooltip.h

sub dzl_shortcut_tooltip_get_accel (DzlShortcutTooltip $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_get_command_id (DzlShortcutTooltip $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_get_title (DzlShortcutTooltip $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_get_widget (DzlShortcutTooltip $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_new ()
  returns DzlShortcutTooltip
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_set_accel (
  DzlShortcutTooltip $self,
  Str                $accel
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_set_command_id (
  DzlShortcutTooltip $self,
  Str                $command_id
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_set_title (
  DzlShortcutTooltip $self,
  Str                $title
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_tooltip_set_widget (
  DzlShortcutTooltip $self,
  GtkWidget $widget
)
  is native(dazzle)
  is export
{ * }

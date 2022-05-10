use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Shortcut::Controller;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-controller.h

sub dzl_shortcut_controller_add_command_action (
  DzlShortcutController $self,
  Str                   $command_id,
  Str                   $default_accel,
  DzlShortcutPhase      $phase,
  Str                   $action
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_add_command_callback (
  DzlShortcutController $self,
  Str                   $command_id,
  Str                   $default_accel,
  DzlShortcutPhase      $phase,
                        &callback (GtkWidget, gpointer),
  gpointer              $callback_data,
                        &callback_data_destroy (gpointer)
)
  is native(dazzle)
  is export
{ * }

# cw: varargs support is out of scope!
#
# sub dzl_shortcut_controller_add_command_signal (
#   DzlShortcutController $self,
#   Str                   $command_id,
#   Str                   $default_accel,
#   DzlShortcutPhase      $phase,
#   Str                   $signal_name,
#   guint                 $n_args
#                         ...
# )
#   is native(dazzle)
#   is export
# { * }

sub dzl_shortcut_controller_execute_command (
  DzlShortcutController $self,
  Str                   $command
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_find (GtkWidget $widget)
  returns DzlShortcutController
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_get_context (DzlShortcutController $self)
  returns DzlShortcutContext
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_get_context_for_phase (
  DzlShortcutController $self,
  DzlShortcutPhase      $phase
)
  returns DzlShortcutContext
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_get_current_chord (DzlShortcutController $self)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_get_manager (DzlShortcutController $self)
  returns DzlShortcutManager
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_get_widget (DzlShortcutController $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_new (GtkWidget $widget)
  returns DzlShortcutController
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_remove_accel (
  DzlShortcutController $self,
  Str                   $accel,
  DzlShortcutPhase      $phase
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_set_context_by_name (
  DzlShortcutController $self,
  Str                   $name
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_set_manager (
  DzlShortcutController $self,
  DzlShortcutManager    $manager
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_controller_try_find (GtkWidget $widget)
  returns DzlShortcutController
  is native(dazzle)
  is export
{ * }

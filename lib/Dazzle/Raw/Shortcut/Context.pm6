use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Types;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Shortcut::Context;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-context.h

sub dzl_shortcut_context_activate (
  DzlShortcutContext $self,
  GtkWidget          $widget,
  DzlShortcutChord   $chord
)
  returns DzlShortcutMatch
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_add_action (
  DzlShortcutContext $self,
  Str $accel,
  Str $detailed_action_name
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_add_command (
  DzlShortcutContext $self,
  Str $accel,
  Str $command
)
  is native(dazzle)
  is export
{ * }


# cw: Var args are out of scope!
# sub dzl_shortcut_context_add_signal (
#   DzlShortcutContext $self,
#   Str                $accel,
#   Str                $signal_name,
#   guint              $n_args,
#   ...
# )
#   is native(dazzle)
#   is export
# { * }
#
# sub dzl_shortcut_context_add_signal_va_list (
#   DzlShortcutContext $self,
#   Str $accel,
#   Str $signal_name,
#   guint $n_args,
#   va_list $args
# )
#   is native(dazzle)
#   is export
# { * }

sub dzl_shortcut_context_add_signalv (
  DzlShortcutContext $self,
  Str                $accel,
  Str                $signal_name,
  GArray             $values
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_get_name (DzlShortcutContext $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_load_from_data (
  DzlShortcutContext      $self,
  Str                     $data,
  gssize                  $len,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_load_from_resource (
  DzlShortcutContext      $self,
  Str                     $resource_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_new (Str $name)
  returns DzlShortcutContext
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_context_remove (DzlShortcutContext $self, Str $accel)
  returns uint32
  is native(dazzle)
  is export
{ * }

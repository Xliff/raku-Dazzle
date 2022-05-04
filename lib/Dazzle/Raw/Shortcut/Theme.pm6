use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Shortcut::Theme;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-theme.h

sub dzl_shortcut_theme_add_command (
  DzlShortcutTheme $self,
  Str              $accelerator,
  Str              $command
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_add_context (
  DzlShortcutTheme   $self,
  DzlShortcutContext $context
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_add_css_resource (DzlShortcutTheme $self, Str $path)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_find_context_by_name (DzlShortcutTheme $self, Str $name)
  returns DzlShortcutContext
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_find_default_context (
  DzlShortcutTheme $self,
  GtkWidget        $widget
)
  returns DzlShortcutContext
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_chord_for_action (
  DzlShortcutTheme $self,
  Str              $detailed_action_name
)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_chord_for_command (
  DzlShortcutTheme $self,
  Str              $command
)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_name (DzlShortcutTheme $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_parent (DzlShortcutTheme $self)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_parent_name (DzlShortcutTheme $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_subtitle (DzlShortcutTheme $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_get_title (DzlShortcutTheme $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_load_from_data (
  DzlShortcutTheme        $self,
  Str                     $data,
  gssize                  $len,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_load_from_file (
  DzlShortcutTheme        $self,
  GFile                   $file,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_load_from_path (
  DzlShortcutTheme        $self,
  Str                     $path,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_new (Str $name)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_remove_css_resource (DzlShortcutTheme $self, Str $path)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_save_to_file (
  DzlShortcutTheme        $self,
  GFile                   $file,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_save_to_path (
  DzlShortcutTheme        $self,
  Str                     $path,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_save_to_stream (
  DzlShortcutTheme        $self,
  GOutputStream           $stream,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_set_accel_for_action (
  DzlShortcutTheme $self,
  Str              $detailed_action_name,
  Str              $accel,
  DzlShortcutPhase $phase
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_set_accel_for_command (
  DzlShortcutTheme $self,
  Str              $command,
  Str              $accel,
  DzlShortcutPhase $phase
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_set_chord_for_action (
  DzlShortcutTheme $self,
  Str              $detailed_action_name,
  DzlShortcutChord $chord,
  DzlShortcutPhase $phase
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_set_chord_for_command (
  DzlShortcutTheme $self,
  Str              $command,
  DzlShortcutChord $chord,
  DzlShortcutPhase $phase
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_set_parent_name (
  DzlShortcutTheme $self,
  Str              $parent_name
)
  is native(dazzle)
  is export
{ * }

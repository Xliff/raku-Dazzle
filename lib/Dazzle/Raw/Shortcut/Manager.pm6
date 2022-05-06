use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Structs;

unit package Dazzle::Raw::Shortcuts::Manager;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-manager.h

sub dzl_shortcut_manager_add_action (
  DzlShortcutManager $self,
  Str                $detailed_action_name,
  Str                $section,
  Str                $group,
  Str                $title,
  Str                $subtitle
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_add_command (
  DzlShortcutManager $self,
  Str                $command,
  Str                $section,
  Str                $group,
  Str                $title,
  Str                $subtitle
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_add_shortcut_entries (
  DzlShortcutManager $self,
  Pointer            $shortcuts,           # DzlShortcutEntry[]
  guint              $n_shortcuts,
  Str                $translation_domain
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_add_shortcuts_to_window (
  DzlShortcutManager $self,
  DzlShortcutsWindow $window
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_append_search_path (
  DzlShortcutManager $self,
  Str                $directory
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_get_default ()
  returns DzlShortcutManager
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_get_theme (DzlShortcutManager $self)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_get_theme_by_name (
  DzlShortcutManager $self,
  Str                $theme_name
)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_get_theme_name (DzlShortcutManager $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_get_user_dir (DzlShortcutManager $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_handle_event (
  DzlShortcutManager $self,
  GdkEventKey        $event,
  GtkWidget          $toplevel
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_prepend_search_path (
  DzlShortcutManager $self,
  Str                $directory
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_queue_reload (DzlShortcutManager $self)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_reload (
  DzlShortcutManager $self,
  GCancellable       $cancellable
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_remove_search_path (
  DzlShortcutManager $self,
  Str                $directory
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_set_theme (
  DzlShortcutManager $self,
  DzlShortcutTheme   $theme
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_set_theme_name (
  DzlShortcutManager $self,
  Str                $theme_name
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_manager_set_user_dir (
  DzlShortcutManager $self,
  Str                $user_dir
)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Shortcut::Model;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-model.h

sub dzl_shortcut_model_get_manager (DzlShortcutModel $self)
  returns DzlShortcutManager
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_get_theme (DzlShortcutModel $self)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_new ()
  returns GtkTreeModel
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_rebuild (DzlShortcutModel $self)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_set_chord (
  DzlShortcutModel $self,
  GtkTreeIter      $iter,
  DzlShortcutChord $chord
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_set_manager (
  DzlShortcutModel   $self,
  DzlShortcutManager $manager
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_model_set_theme (
  DzlShortcutModel $self,
  DzlShortcutTheme $theme
)
  is native(dazzle)
  is export
{ * }

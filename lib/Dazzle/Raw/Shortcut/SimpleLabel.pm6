use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Shortcut::SimpleLabel;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-simple-label.h

sub dzl_shortcut_simple_label_get_accel (DzlShortcutSimpleLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_get_action (DzlShortcutSimpleLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_get_command (DzlShortcutSimpleLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_get_title (DzlShortcutSimpleLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_new ()
  returns DzlShortcutSimpleLabel
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_set_accel (
  DzlShortcutSimpleLabel $self,
  Str                    $accel
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_set_action (
  DzlShortcutSimpleLabel $self,
  Str                    $action
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_set_command (
  DzlShortcutSimpleLabel $self,
  Str                    $command
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_simple_label_set_title (
  DzlShortcutSimpleLabel $self,
  Str                    $title
)
  is native(dazzle)
  is export
{ * }

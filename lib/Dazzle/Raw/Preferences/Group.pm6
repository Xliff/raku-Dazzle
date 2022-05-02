use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Types;

unit package Dazzle::Raw::Preferences::Group;

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-group.h

sub dzl_preferences_group_add (DzlPreferencesGroup $self, GtkWidget $widget)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_group_get_priority (DzlPreferencesGroup $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_group_get_size_group (
  DzlPreferencesGroup $self,
  guint               $column
)
  returns GtkSizeGroup
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_group_get_title (DzlPreferencesGroup $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_group_refilter (
  DzlPreferencesGroup $self,
  DzlPatternSpec      $spec
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_group_set_map (DzlPreferencesGroup $self, GHashTable $map)
  is native(dazzle)
  is export
{ * }

# Infrerred`

sub dzl_preferences_group_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

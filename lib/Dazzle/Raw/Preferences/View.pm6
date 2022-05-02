use v6.c;

use NativeCall;

use GLib::Raw::Types;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Preferences::View;

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-view.h

sub dzl_preferences_view_get_show_search_entry (DzlPreferencesView $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_view_get_use_sidebar (DzlPreferencesView $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_view_new ()
  returns DzlPreferencesView
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_view_reapply_filter (DzlPreferencesView $self)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_view_set_show_search_entry (
  DzlPreferencesView $self,
  gboolean           $show_search_entry
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_view_set_use_sidebar (
  DzlPreferencesView $self,
  gboolean           $use_sidebar
)
  is native(dazzle)
  is export
{ * }

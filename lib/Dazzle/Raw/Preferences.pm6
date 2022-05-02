use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Preferences;

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences.h

sub dzl_preferences_add_custom (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  GtkWidget      $widget,
  Str            $keywords,
  gint           $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_file_chooser (
  DzlPreferences       $self,
  Str                  $page_name,
  Str                  $group_name,
  Str                  $schema_id,
  Str                  $key,
  Str                  $path,
  Str                  $title,
  Str                  $subtitle,
  GtkFileChooserAction $action,
  Str                  $keywords,
  gint                 $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_font_button (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  Str            $schema_id,
  Str            $key,
  Str            $title,
  Str            $keywords,
  gint           $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_group (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  Str            $title,
  gint           $priority
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_list_group (
  DzlPreferences   $self,
  Str              $page_name,
  Str              $group_name,
  Str              $title,
  GtkSelectionMode $mode,
  gint             $priority
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_page (
  DzlPreferences $self,
  Str            $page_name,
  Str            $title,
  gint           $priority
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_radio (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  Str            $schema_id,
  Str            $key,
  Str            $path,
  Str            $variant_string,
  Str            $title,
  Str            $subtitle,
  Str            $keywords,
  gint           $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_spin_button (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  Str            $schema_id,
  Str            $key,
  Str            $path,
  Str            $title,
  Str            $subtitle,
  Str            $keywords,
  gint           $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_switch (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  Str            $schema_id,
  Str            $key,
  Str            $path,
  Str            $variant_string,
  Str            $title,
  Str            $subtitle,
  Str            $keywords,
  gint           $priority
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_add_table_row (
  DzlPreferences $self,
  Str            $page_name,
  Str            $group_name,
  GtkWidget      $first_widget,
  GtkWidget
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_get_widget (DzlPreferences $self, guint $widget_id)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_remove_id (DzlPreferences $self, guint $widget_id)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_set_page (
  DzlPreferences $self,
  Str            $page_name,
  GHashTable     $map
)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Augments::GTK;

### /usr/src/libdazzle-3.42.0/src/util/dzl-gtk.h

sub dzl_gtk_widget_action (
  GtkWidget $widget,
  Str       $group,
  Str       $name,
  GVariant  $param
)
  returns uint32
  is native(dazzle)
  is export
{ * }

# cw: varargs out of scope
#
# sub dzl_gtk_widget_action_set (
#   GtkWidget $widget,
#   Str $group,
#   Str $name,
#   Str $first_property,
#   ...
# )
#   is native(dazzle)
#   is export
# { * }

sub dzl_gtk_widget_action_with_string (
  GtkWidget $widget,
  Str       $group,
  Str       $name,
  Str       $param
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_add_style_class (GtkWidget $widget, Str $class_name)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_list_store_insert_sorted (
  GtkListStore $store,
  GtkTreeIter  $iter,
  gpointer     $key,
  guint        $compare_column,
               &compare_func,
  gpointer     $compare_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_text_buffer_remove_tag (
  GtkTextBuffer $buffer,
  GtkTextTag    $tag,
  GtkTextIter   $start,
  GtkTextIter   $end,
  gboolean      $minimal_damage
)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_find_child_typed (GtkWidget $widget, GType $type)
  returns Pointer
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_get_relative (GtkWidget $widget, GType $relative_type)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_hide_with_fade (GtkWidget $widget)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_is_ancestor_or_relative (
  GtkWidget $widget,
  GtkWidget $ancestor
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_mux_action_groups (
  GtkWidget $widget,
  GtkWidget $from_widget,
  Str       $mux_key
)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_remove_style_class (GtkWidget $widget, Str $class_name)
  is native(dazzle)
  is export
{ * }

sub dzl_gtk_widget_show_with_fade (GtkWidget $widget)
  is native(dazzle)
  is export
{ * }

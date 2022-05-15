use v6.c;

use Method::Also;

use MONKEY-TYPING;

use Dazzle::Raw::Types;
use Dazzle::Raw::Augment::GTK;

use GTK::Widget;
use GTK::ListStore;
use GTK::TextBuffer;

augment class GTK::Widget {

  method action (Str() $group, Str() $name, GVariant() $param) {
    dzl_gtk_widget_action(self.GtkWidget, $group, $name, $param);
  }

  method action_with_string (Str() $group, Str() $name, Str() $param)
    is also<action-with-string>
  {
    dzl_gtk_widget_action_with_string(self.GtkWidget, $group, $name, $param);
  }

  method add_style_class (Str() $class_name) is also<add-style-class> {
    dzl_gtk_widget_add_style_class(self.GtkWidget, $class_name);
  }

  method find_child_typed (Int() $type) is also<find-child-typed> {
    my GType $t = $type;

    dzl_gtk_widget_find_child_typed(self.GtkWidget, $t);
  }

  method get_relative (Int() $relative_type) is also<get-relative> {
    my GType $r = $relative_type;

    dzl_gtk_widget_get_relative(self.GtkWidget, $r);
  }

  method hide_with_fade is also<hide-with-fade> {
    dzl_gtk_widget_hide_with_fade(self.GtkWidget);
  }

  method is_ancestor_or_relative (GtkWidget() $ancestor)
    is also<is-ancestor-or-relative>
  {
    dzl_gtk_widget_is_ancestor_or_relative(self.GtkWidget, $ancestor);
  }

  method mux_action_groups (GtkWidget() $from_widget, Str() $mux_key)
    is also<mux-action-groups>
  {
    dzl_gtk_widget_mux_action_groups(self.GtkWidget, $from_widget, $mux_key);
  }

  method remove_style_class (Str() $class_name) is also<remove-style-class> {
    dzl_gtk_widget_remove_style_class(self.GtkWidget, $class_name);
  }

  method show_with_fade is also<show-with-fade> {
    dzl_gtk_widget_show_with_fade(self.GtkWidget);
  }

}


augment class GTK::ListStore {

  method insert_sorted (
    GtkTreeIter() $iter,
    gpointer      $key,
    Int()         $compare_column,
                  &compare_func,
    gpointer      $compare_data
  ) {
    my guint $c = $compare_column;

    dzl_gtk_list_store_insert_sorted(
      self.GtkListStore,
      $iter,
      $key,
      $c,
      &compare_func,
      $compare_data
    );
  }

}

augment class GTK::TextBuffer {

  multi method remove_tag_dazzle (
    GtkTextTag()   $tag,
    GtkTextIter()  $start,
    GtkTextIter()  $end,
    Int()          $minimal_damage
  ) {
    my gboolean $m = $minimal_damage.so.Int;

    dzl_gtk_text_buffer_remove_tag(self.GtkTextBuffer, $tag, $start, $end, $m);
  }

}

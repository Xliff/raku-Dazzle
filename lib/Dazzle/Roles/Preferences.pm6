use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Preferences;

use GTK::Widget;

role Dazzle::Roles::Preferences {
  has DzlPreferences $!dp is implementor;

  method roleInit-DzlPreferences {
    return if $!dp;

    my \i = findProperImplementor(self.^attributes);
    $!dp = cast( DzlPreferences, i.get_value(self) );
  }

  method Dazzle::Raw::Definitions::DzlPreferences
  { $!dp }

  method add_custom (
    Str()       $page_name,
    Str()       $group_name,
    GtkWidget() $widget,
    Str()       $keywords,
    Int()       $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_custom(
      $!dp,
      $page_name,
      $group_name,
      $widget,
      $keywords,
      $p
    );
  }

  method add_file_chooser (
    Str() $page_name,
    Str() $group_name,
    Str() $schema_id,
    Str() $key,
    Str() $path,
    Str() $title,
    Str() $subtitle,
    Int() $action,
    Str() $keywords,
    Int() $priority
  ) {
    my gint                 $p = $priority;
    my GtkFileChooserAction $a = $action;

    dzl_preferences_add_file_chooser(
      $!dp,
      $page_name,
      $group_name,
      $schema_id,
      $key,
      $path,
      $title,
      $subtitle,
      $a,
      $keywords,
      $p
    );
  }

  method add_font_button (
    Str() $page_name,
    Str() $group_name,
    Str() $schema_id,
    Str() $key,
    Str() $title,
    Str() $keywords,
    Int() $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_font_button(
      $!dp,
      $page_name,
      $group_name,
      $schema_id,
      $key,
      $title,
      $keywords,
      $p
    );
  }

  method add_group (
    Str() $page_name,
    Str() $group_name,
    Str() $title,
    Int() $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_group($!dp, $page_name, $group_name, $title, $p);
  }

  method add_list_group (
    Str() $page_name,
    Str() $group_name,
    Str() $title,
    Int() $mode,
    Int() $priority
  ) {
    my GtkSelectionMode $m = $mode;
    my gint             $p = $priority;

    dzl_preferences_add_list_group(
      $!dp,
      $page_name,
      $group_name,
      $title,
      $mode,
      $p
    );
  }

  method add_page (Str() $page_name, Str() $title, Int() $priority) {
    my gint $p = $priority;

    dzl_preferences_add_page($!dp, $page_name, $title, $p);
  }

  method add_radio (
    Str() $page_name,
    Str() $group_name,
    Str() $schema_id,
    Str() $key,
    Str() $path,
    Str() $variant_string,
    Str() $title,
    Str() $subtitle,
    Str() $keywords,
    Int() $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_radio(
      $!dp,
      $page_name,
      $group_name,
      $schema_id,
      $key,
      $path,
      $variant_string,
      $title,
      $subtitle,
      $keywords,
      $p
    );
  }

  method add_spin_button (
    Str() $page_name,
    Str() $group_name,
    Str() $schema_id,
    Str() $key,
    Str() $path,
    Str() $title,
    Str() $subtitle,
    Str() $keywords,
    Int() $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_spin_button(
      $!dp,
      $page_name,
      $group_name,
      $schema_id,
      $key,
      $path,
      $title,
      $subtitle,
      $keywords,
      $p
    );
  }

  method add_switch (
    Str() $page_name,
    Str() $group_name,
    Str() $schema_id,
    Str() $key,
    Str() $path,
    Str() $variant_string,
    Str() $title,
    Str() $subtitle,
    Str() $keywords,
    Int() $priority
  ) {
    my gint $p = $priority;

    dzl_preferences_add_switch(
      $!dp,
      $page_name,
      $group_name,
      $schema_id,
      $key,
      $path,
      $variant_string,
      $title,
      $subtitle,
      $keywords,
      $p
    );
  }

  # cw: Widgets to a page and group. Var args are out of scope, and this
  #     entire method would need to be reimplemented in Raku.
  # method add_table_row (
  #   Str()       $page_name,
  #   Str()       $group_name,
  #               ...
  # ) {
  #   dzl_preferences_add_table_row($!dp, $page_name, $group_name, ...)
  # }

  method get_widget (Int() $widget_id, :$raw = False, :$widget = False) {
    my guint $w = $widget_id;

    ReturnWidget(
      dzl_preferences_get_widget($!dp, $widget_id),
      $raw,
      $widget
    );
  }

  method remove_id (Int() $widget_id) {
    my guint $w = $widget_id;

    dzl_preferences_remove_id($!dp, $widget_id);
  }

  method set_page (Str() $page_name, GHashTable() $map) {
    dzl_preferences_set_page($!dp, $page_name, $map);
  }

}

our subset DzlPreferencesAncestry is export of Mu
  where DzlPreferences | GObject;

class Dazzle::Preferences {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Preferences;

  submethod BUILD ( :$dzl-preferences ) {
    self.setDzlPreferences($dzl-preferences) if $dzl-preferences;
  }

  method setDzlPreferences (DzlPreferencesAncestry $_) {
    my $to-parent;


    $!dp = do {
      when DzlPreferences {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferences, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (DzlPreferencesAncestry $dzl-preferences, :$ref = True) {
    return Nil unless $dzl-preferences;

    my $o = self.bless( :$dzl-preferences );
    $o.ref if $ref;
    $o;
  }

}

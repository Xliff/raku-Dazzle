use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Manager;

use Dazzle::Shortcut::Theme;

use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;

our subset DzlShortcutManagerAncestry is export of Mu
  where DzlShortcutManager | GObject;

class Dazzle::Shortcut::Manager {
  also does GLib::Roles::Object;

  has DzlShortcutManager $!dsm;

  submethod BUILD (:$dzl-shortcuts-manager) {
    self.setDzlShortcutManager($dzl-shortcuts-manager)
      if $dzl-shortcuts-manager;
  }

  method setDzlShortcutManager (DzlShortcutManagerAncestry $_) {
    my $to-parent;

    $!dsm = do {
      when DzlShortcutManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutManager
    is also<DzlShortcutManager>
  { $!dsm }

  multi method new (
    DzlShortcutManagerAncestry  $dzl-shortcuts-manager,
                                :$ref = True
  ) {
    return Nil unless $dzl-shortcuts-manager;

    my $o = self.bless( :$dzl-shortcuts-manager );
    $o.ref if $ref;
    $o;
  }
  multi method get_default is static is also<get-default> {
    my $dzl-shortcut-manager = dzl_shortcut_manager_get_default();

    $dzl-shortcut-manager ?? self.bless( :$dzl-shortcut-manager ) !! Nil
  }

  method add_action (
    Str() $detailed_action_name,
    Str() $section,
    Str() $group,
    Str() $title,
    Str() $subtitle
  )
    is also<add-action>
  {
    dzl_shortcut_manager_add_action(
      $!dsm,
      $detailed_action_name,
      $section,
      $group,
      $title,
      $subtitle
    );
  }

  method add_command (
    Str() $command,
    Str() $section,
    Str() $group,
    Str() $title,
    Str() $subtitle
  )
    is also<add-command>
  {
    dzl_shortcut_manager_add_command(
      $!dsm,
      $command,
      $section,
      $group,
      $title,
      $subtitle
    );
  }

  proto method add_shortcut_entries (|)
    is also<add-shortcut-entries>
  { *}

  multi method add_shortcut_entries (
          @shortcuts,
    Str() $translation_domain
  ) {
    samewith(
      GLib::Roles::TypedBuffer[DzlShortcutEntry].new(@shortcuts).p,
      @shortcuts.elems,
      $translation_domain
    );
  }
  multi method add_shortcut_entries (
    gpointer $shortcuts,
    Int()    $n_shortcuts,
    Str()    $translation_domain
  ) {
    my guint $n = $n_shortcuts;

    dzl_shortcut_manager_add_shortcut_entries(
      $!dsm,
      $shortcuts,
      $n_shortcuts,
      $translation_domain
    );
  }

  method add_shortcuts_to_window (DzlShortcutsWindow() $window) is also<add-shortcuts-to-window> {
    dzl_shortcut_manager_add_shortcuts_to_window($!dsm, $window);
  }

  method append_search_path (Str() $directory) is also<append-search-path> {
    dzl_shortcut_manager_append_search_path($!dsm, $directory);
  }

  method get_theme ( :$raw = False ) is also<get-theme> {
    propReturnObject(
      dzl_shortcut_manager_get_theme($!dsm),
      $raw,
      |Dazzle::Shortcut::Theme.getTypePair
    );
  }

  method get_theme_by_name (Str() $theme_name, :$raw = False) is also<get-theme-by-name> {
    propReturnObject(
      dzl_shortcut_manager_get_theme_by_name($!dsm, $theme_name),
      $raw,
      |Dazzle::Shortcut::Theme.getTypePair
    );
  }

  method get_theme_name is also<get-theme-name> {
    dzl_shortcut_manager_get_theme_name($!dsm);
  }

  method get_user_dir is also<get-user-dir> {
    dzl_shortcut_manager_get_user_dir($!dsm);
  }

  method handle_event (GdkEventKey() $event, GtkWidget() $toplevel) is also<handle-event> {
    dzl_shortcut_manager_handle_event($!dsm, $event, $toplevel);
  }

  method prepend_search_path (Str() $directory) is also<prepend-search-path> {
    dzl_shortcut_manager_prepend_search_path($!dsm, $directory);
  }

  method queue_reload is also<queue-reload> {
    dzl_shortcut_manager_queue_reload($!dsm);
  }

  method reload (GCancellable() $cancellable = GCancellable) {
    dzl_shortcut_manager_reload($!dsm, $cancellable);
  }

  method remove_search_path (Str() $directory) is also<remove-search-path> {
    dzl_shortcut_manager_remove_search_path($!dsm, $directory);
  }

  method set_theme (DzlShortcutTheme() $theme) is also<set-theme> {
    dzl_shortcut_manager_set_theme($!dsm, $theme);
  }

  method set_theme_name (Str() $theme_name) is also<set-theme-name> {
    dzl_shortcut_manager_set_theme_name($!dsm, $theme_name);
  }

  method set_user_dir (Str() $user_dir) is also<set-user-dir> {
    dzl_shortcut_manager_set_user_dir($!dsm, $user_dir);
  }

}

#our constant Dazzle::Shortcuts::Manager := Dazzle::Shortcut::Manager;

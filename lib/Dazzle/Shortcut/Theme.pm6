use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Theme;

use GLib::Value;

use GLib::Roles::Object;

our subset DzlShortcutThemeAncestry is export of Mu
  where DzlShortcutTheme | GObject;

class Dazzle::Shortcut::Theme {
  also does GLib::Roles::Object;

  has DzlShortcutTheme $!dst is implementor;

  submethod BUILD (:$dzl-shortcut-theme) {
    self.setDzlShortcutTheme($dzl-shortcut-theme) if $dzl-shortcut-theme;
  }

  method setDzlShortcutTheme (DzlShortcutThemeAncestry $_) {
    my $to-parent;

    $!dst = do {
      when DzlShortcutTheme {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutTheme, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutTheme
    is also<DzlShortcutTheme>
  { $!dst }

  multi method new (
    DzlShortcutThemeAncestry  $dzl-shortcut-theme,
                             :$ref                 = True
  ) {
    return Nil unless $dzl-shortcut-theme;

    my $o = self.bless( :$dzl-shortcut-theme );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $dzl-shortcut-theme = dzl_shortcut_theme_new($name);

    $dzl-shortcut-theme ?? self.bless( :$dzl-shortcut-theme ) !! Nil;
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'name is a construct-only attribute'
      }
    );
  }

  # Type: string
  method parent-name is rw  is g-property is also<parent_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('parent-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('parent-name', $gv);
      }
    );
  }

  # Type: string
  method subtitle is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('subtitle', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method add_command (Str() $accelerator, Str() $command)
    is also<add-command>
  {
    dzl_shortcut_theme_add_command($!dst, $accelerator, $command);
  }

  method add_context (DzlShortcutContext() $context) is also<add-context> {
    dzl_shortcut_theme_add_context($!dst, $context);
  }

  method add_css_resource (Str() $path) is also<add-css-resource> {
    dzl_shortcut_theme_add_css_resource($!dst, $path);
  }

  method find_context_by_name (Str() $name, :$raw = False)
    is also<find-context-by-name>
  {
    propReturnObject(
      dzl_shortcut_theme_find_context_by_name($!dst, $name),
      $raw,
      |Dazzle::Shortcut::Context.getTypePair
    );
  }

  method find_default_context (GtkWidget() $widget, :$raw = False)
    is also<find-default-context>
  {
    propReturnObject(
      dzl_shortcut_theme_find_default_context($!dst, $widget),
      $raw,
      |Dazzle::Shortcut::Context.getTypePair
    );
  }

  method get_chord_for_action (Str() $detailed_action_name, :$raw = False)
    is also<get-chord-for-action>
  {
    propReturnObject(
      dzl_shortcut_theme_get_chord_for_action($!dst, $detailed_action_name),
      $raw,
      |Dazzle::Shortcut::Chord.getTypePair
    );
  }

  method get_chord_for_command (Str() $command, :$raw = False)
    is also<get-chord-for-command>
  {
    propReturnObject(
      dzl_shortcut_theme_get_chord_for_command($!dst, $command),
      $raw,
      |Dazzle::Shortcut::Chord.getTypePair
    );
  }

  method get_name is also<get-name> {
    dzl_shortcut_theme_get_name($!dst);
  }

  method get_parent ( :$raw = False ) is also<get-parent> {
    propReturnObject(
      dzl_shortcut_theme_get_parent($!dst),
      $raw,
      |self.getTypePair
    );
  }

  method get_parent_name is also<get-parent-name> {
    dzl_shortcut_theme_get_parent_name($!dst);
  }

  method get_subtitle is also<get-subtitle> {
    dzl_shortcut_theme_get_subtitle($!dst);
  }

  method get_title is also<get-title> {
    dzl_shortcut_theme_get_title($!dst);
  }

  method load_from_data (
    Str()                   $data,
    Int()                   $len,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-from-data>
  {
    my gssize $l = $len;

    clear_error;
    my $rv = so dzl_shortcut_theme_load_from_data($!dst, $data, $l, $error);
    set_error($error);
    $rv;
  }

  method load_from_file (
    GFile()                 $file,
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<load-from-file>
  {
    clear_error;
    my $rv = so dzl_shortcut_theme_load_from_file(
      $!dst,
      $file,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method load_from_path (
    Str()                   $path,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<load-from-path>
  {
    clear_error;
    my $rv =  so dzl_shortcut_theme_load_from_path(
      $!dst,
      $path,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_css_resource (Str() $path) is also<remove-css-resource> {
    dzl_shortcut_theme_remove_css_resource($!dst, $path);
  }

  method save_to_file (
    GFile()                 $file,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<save-to-file>
  {
    clear_error;
    my $rv = so dzl_shortcut_theme_save_to_file(
      $!dst,
      $file,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method save_to_path (
    Str()                   $path,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<save-to-path>
  {
    clear_error;
    my $rv = so dzl_shortcut_theme_save_to_path(
      $!dst,
      $path,
      $cancellable,
      $error
    );
    set_error($error);
  }

  method save_to_stream (
    GOutputStream()         $stream,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<save-to-stream>
  {
    clear_error;
    my $rv = so dzl_shortcut_theme_save_to_stream(
      $!dst,
      $stream,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_accel_for_action (
    Str() $detailed_action_name,
    Str() $accel,
    Int() $phase
  )
    is also<set-accel-for-action>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_theme_set_accel_for_action(
      $!dst,
      $detailed_action_name,
      $accel,
      $p
    );
  }

  method set_accel_for_command (
    Str() $command,
    Str() $accel,
    Int() $phase
  )
    is also<set-accel-for-command>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_theme_set_accel_for_command($!dst, $command, $accel, $p);
  }

  method set_chord_for_action (
    Str()              $detailed_action_name,
    DzlShortcutChord() $chord,
    Int()              $phase
  )
    is also<set-chord-for-action>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_theme_set_chord_for_action(
      $!dst,
      $detailed_action_name,
      $chord,
      $p
    );
  }

  method set_chord_for_command (
    Str()              $command,
    DzlShortcutChord() $chord,
    Int()              $phase
  )
    is also<set-chord-for-command>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_theme_set_chord_for_command($!dst, $command, $chord, $p);
  }

  method set_parent_name (Str() $parent_name) is also<set-parent-name> {
    dzl_shortcut_theme_set_parent_name($!dst, $parent_name);
  }

}

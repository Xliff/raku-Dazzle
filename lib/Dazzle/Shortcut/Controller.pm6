use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Controller;

use GTK::Widget;
use Dazzle::Shortcut::Context;
use Dazzle::Shortcut::Manager;

use GLib::Roles::Object;

our subset DzlShortcutControllerAncestry is export of Mu
  where DzlShortcutController | GObject;

class Dazzle::Shortcut::Controller {
  also does GLib::Roles::Object;

  has DzlShortcutController $!dsc is implementor;

  submethod BUILD (:$dzl-shortcut-controller) {
    self.setDzlShortcutController($dzl-shortcut-controller) if $dzl-shortcut-controller;
  }

  method setDzlShortcutController (DzlShortcutControllerAncestry $_) {
    my $to-parent;

    $!dsc = do {
      when DzlShortcutController {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutController, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutController
    is also<DzlShortcutController>
  { $!dsc }

  multi method new (
    DzlShortcutControllerAncestry  $dzl-shortcut-controller,
                                  :$ref                      = True
  ) {
    return Nil unless $dzl-shortcut-controller;

    my $o = self.bless( :$dzl-shortcut-controller );
    $o.ref if $ref;
    $o;
  }
  multi method new (GtkWidget() $w, :$widget is required) {
    ::?CLASS.new-with-widget($);
  }
  multi method new-with-widget (GtkWidget() $widget) {
    my $dzl-shortcut-controller = dzl_shortcut_controller_new($widget);

    $dzl-shortcut-controller ?? self.bless( :$dzl-shortcut-controller ) !! Nil;
  }

  method find (GtkWidget() $widget) is static {
    my $dzl-shortcut-controller = dzl_shortcut_controller_find($widget);

    $dzl-shortcut-controller ?? self.bless( :$dzl-shortcut-controller ) !! Nil;
  }

  # Type: DzlShortcutContext
  method context ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Dazzle::Shortcut::Context.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('context', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Shortcut::Context.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'context does not allow writing'
      }
    );
  }

  # Type: DzlShortcutChord
  method current-chord ( :$raw = False )
    is rw
    is g-property
    is also<current_chord>
  {
    my $gv = GLib::Value.new( Dazzle::Shortcut::Chord.get_type );
    Proxy.new(      FETCH => sub ($) {
        self.prop_get('current-chord', $gv);

        propReturnObject(
          $gv.pointer,
          $raw,
          |Dazzle::Shortcut::Chord.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'current-chord does not allow writing'
      }
    );
  }

  # Type: DzlShortcutManager
  method manager ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Dazzle::Shortcut::Manager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('manager', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Shortcut::Manager.getTypePair
        );
      },
      STORE => -> $, DzlShortcutManager() $val is copy {
        $gv.object = $val;
        self.prop_set('manager', $gv);
      }
    );
  }

  # Type: GtkWidget
  method widget ( :$raw = False, :$widget = False ) is rw is g-property {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('widget', $gv);
        ReturnWidget(
          $gv.object,
          $raw,
          $widget
        );
      },
      STORE => -> $,  $val is copy {
        warn 'widget is a construct-only attribute'
      }
    );
  }

  method reset {
    self.connect($!dsc, 'reset');
  }

  method set-context-named {
    self.connect-string($!dsc, 'set-context-named');
  }

  method add_command_action (
    Str() $command_id,
    Str() $default_accel,
    Int() $phase,
    Str() $action
  )
    is also<add-command-action>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_controller_add_command_action(
      $!dsc,
      $command_id,
      $default_accel,
      $p,
      $action
    );
  }

  method add_command_callback (
    Str()    $command_id,
    Str()    $default_accel,
    Int()    $phase,
             &callback,
    gpointer $callback_data,
             &callback_data_destroy
  )
    is also<add-command-callback>
  {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_controller_add_command_callback(
      $!dsc,
      $command_id,
      $default_accel,
      $p,
      &callback,
      $callback_data,
      &callback_data_destroy
    );
  }

  # cw: Varargs not supported...
  # method add_command_signal (...)

  method execute_command (Str() $command) is also<execute-command> {
    dzl_shortcut_controller_execute_command($!dsc, $command);
  }

  method get_context ( :$raw = False ) is also<get-context> {
    propReturnObject(
      dzl_shortcut_controller_get_context($!dsc),
      $raw,
      |Dazzle::Shortcut::Contexct.getTypePair
    );
  }

  method get_context_for_phase ( Int() $phase, :$raw = False )
    is also<get-context-for-phase>
  {
    my DzlShortcutPhase $p = $phase;

    propReturnObject(
      dzl_shortcut_controller_get_context_for_phase($!dsc, $p),
      $raw,
      |Dazzle::Shortcut::Contexct.getTypePair
    );
  }

  method get_current_chord ( :$raw = False ) is also<get-current-chord> {
    propReturnObject(
      dzl_shortcut_controller_get_current_chord($!dsc),
      $raw,
      |Dazzle::Shortcut::Chord.getTypePair
    )
  }

  method get_manager ( :$raw = False ) is also<get-manager> {
    propReturnObject(
      dzl_shortcut_controller_get_manager($!dsc),
      $raw,
      |Dazzle::Shortcut::Manager.getTypePair
    )
  }

  method get_widget ( :$raw = False, :$widget = False ) is also<get-widget> {
    ReturnWidget(
      dzl_shortcut_controller_get_widget($!dsc),
      $raw,
      $widget
    )
  }

  method remove_accel (Str() $accel, Int() $phase) is also<remove-accel> {
    my DzlShortcutPhase $p = $phase;

    dzl_shortcut_controller_remove_accel($!dsc, $accel, $phase);
  }

  method set_context_by_name (Str() $name) is also<set-context-by-name> {
    dzl_shortcut_controller_set_context_by_name($!dsc, $name);
  }

  method set_manager (DzlShortcutManager() $manager) is also<set-manager> {
    dzl_shortcut_controller_set_manager($!dsc, $manager);
  }

  # cw: Return type?!
  method try_find (GtkWidget() $w) is also<try-find> {
    dzl_shortcut_controller_try_find($w);
  }

}

use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Context;

use GLib::Value;

use GLib::Roles::Object;

our subset DzlShortcutContextAncestry is export of Mu
  where DzlShortcutContext | GObject;

class Dazzle::Shortcut::Context {
  also does GLib::Roles::Object;

  has DzlShortcutContext $!dsc is implementor;

  submethod BUILD (:$dzl-shortcut-context) {
    self.setDzlShortcutContext($dzl-shortcut-context) if $dzl-shortcut-context;
  }

  method setDzlShortcutContext (DzlShortcutContextAncestry $_) {
    my $to-parent;

    $!dsc = do {
      when DzlShortcutContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutContext
    is also<DzlShortcutContext>
  { $!dsc }

  multi method new (
    DzlShortcutContextAncestry  $dzl-shortcut-context,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-shortcut-context;

    my $o = self.bless( :$dzl-shortcut-context );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $dzl-shortcut-context = dzl_shortcut_context_new($name);

    $dzl-shortcut-context ?? self.bless( :$dzl-shortcut-context ) !! Nil;
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

  # Type: boolean
  method use-binding-sets is rw  is g-property is also<use_binding_sets> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-binding-sets', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-binding-sets', $gv);
      }
    );
  }

  method activate (GtkWidget() $widget,  DzlShortcutChord() $chord) {
    DzlShortcutMatchEnum(
      dzl_shortcut_context_activate($!dsc, $widget, $chord)
    );
  }

  method add_action (Str() $accel, Str() $detailed_action_name)
    is also<add-action>
  {
    dzl_shortcut_context_add_action($!dsc, $accel, $detailed_action_name);
  }

  method add_command (Str() $accel, Str() $command) is also<add-command> {
    dzl_shortcut_context_add_command($!dsc, $accel, $command);
  }

  method add_signalv (Str() $accel, Str() $signal_name, GArray() $values)
    is also<add-signalv>
  {
    dzl_shortcut_context_add_signalv($!dsc, $accel, $signal_name, $values);
  }

  method get_name is also<get-name> {
    dzl_shortcut_context_get_name($!dsc);
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
    my $rv = so dzl_shortcut_context_load_from_data($!dsc, $data, $len, $error);
    set_error($error);
    $rv;
  }

  method load_from_resource (
    Str()                   $resource_path,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<load-from-resource>
  {
    clear_error;
    my $rv = so dzl_shortcut_context_load_from_resource(
      $!dsc,
      $resource_path,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove (Str() $accel) {
    so dzl_shortcut_context_remove($!dsc, $accel);
  }

}

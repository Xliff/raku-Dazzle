use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::SpinButton;
use GTK::Widget;
use Dazzle::Preferences::Bin;

use GLib::Roles::Signals::Generic;

our subset DzlPreferencesSwitchAncestry is export of Mu
  where DzlPreferencesSwitch | DzlPreferencesBinAncestry;

class Dazzle::Preferences::SpinButton is Dazzle::Preferences::Bin {
  has DzlPreferencesSwitch $!dps;

  submethod BUILD ( :$dzl-preferences-switch ) {
    self.setDzlPreferencesSwitch($dzl-preferences-switch)
      if $dzl-preferences-switch
  }

  method setDzlPreferencesSwitch (DzlPreferencesSwitchAncestry $_) {
    my $to-parent;

    $!dps = do {
      when DzlPreferencesSwitch {
        $to-parent = cast(DzlPreferencesBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesSwitch, $_);
      }
    }
    self.setDzlPreferencesBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesBin
  { $!dps }

  multi method new (
    DzlPreferencesSwitchAncestry  $dzl-preferences-switch,
                                     :$ref                          = True
  ) {
    return Nil unless $dzl-preferences-switch;

    my $o = self.bless( :$dzl-preferences-switch );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()      $is-radio,
    Str()      $key,
    GVariant() $target
  ) {
    my gboolean $ir = $is-radio.so.Int;

    my $dzl-preferences-switch = new_spin_button(
      self.get_type,
      'is-radio',  $ir,
      'key',       $key,
      'target',    $target,
      Str
    );

    $dzl-preferences-switch ?? self.bless( :$dzl-preferences-switch )
                                 !! Nil;
  }

  # Type: boolean
  method is-radio is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-radio', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-radio is a construct-only attribute'
      }
    );
  }

  # Type: string
  method key is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('key', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'key is a construct-only attribute'
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

  # Type: GVariant
  method target ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('target', $gv);
        propReturnObject(
          $gv.pointer,
          $raw,
          |GLib::Variant.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'target is a construct-only attribute'
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

  method activated {
    self.connect($!dps, 'activated');
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &dzl_preferences_switch_get_type,
      $n,
      $t
    );
  }

}

# Inferred

sub dzl_preferences_switch_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

# Constructed

sub new_spin_button (
  GType $type,
  Str,          gboolean, # is-radio
  Str,          Str,      # Key
  Str,          GVariant, # SubTitle
  Str
)
  returns DzlPreferencesSwitch
  is native(dazzle)
  is export
  is symbol('g_object_new')
{ * }

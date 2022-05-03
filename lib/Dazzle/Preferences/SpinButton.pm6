use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::SpinButton;
use GTK::Widget;
use Dazzle::Preferences::Bin;

use GLib::Roles::Signals::Generic;

our subset DzlPreferencesSpinButtonAncestry is export of Mu
  where DzlPreferencesSpinButton | DzlPreferencesBinAncestry;

class Dazzle::Preferences::SpinButton is Dazzle::Preferences::Bin {
  has DzlPreferencesSpinButton $!dpsb;

  submethod BUILD ( :$dzl-preferences-spin-button ) {
    self.setDzlPreferencesSpinButton($dzl-preferences-spin-button)
      if $dzl-preferences-spin-button
  }

  method setDzlPreferencesSpinButton (DzlPreferencesSpinButtonAncestry $_) {
    my $to-parent;

    $!dpsb = do {
      when DzlPreferencesSpinButton {
        $to-parent = cast(DzlPreferencesBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesSpinButton, $_);
      }
    }
    self.setDzlPreferencesBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesBin
  { $!dpsb }

  multi method new (
    DzlPreferencesSpinButtonAncestry  $dzl-preferences-spin-button,
                                     :$ref                          = True
  ) {
    return Nil unless $dzl-preferences-spin-button;

    my $o = self.bless( :$dzl-preferences-spin-button );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str() $key,
    Str() $title     = $key.lc.tc,
    Str() $subtitle  = Str
  ) {
    my $dzl-preferences-spin-button = new_spin_button(
      self.get_type,
      'key',         $key,
      'title',       $title,
      'subtitle',    $subtitle,
      Str
    );

    $dzl-preferences-spin-button ?? self.bless( :$dzl-preferences-spin-button )
                                 !! Nil;
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
        warn 'subtitle is a construct-only attribute'
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
        warn 'title is a construct-only attribute'
      }
    );
  }

  method activate {
    self.connect($!dpsb, 'activate');
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &dzl_preferences_spin_button_get_type,
      $n,
      $t
    );
  }

  method get_spin_button (
    :$raw    = False,
    :$widget = False,
    :$base   = GTK::SpinButton
  ) {
    die 'Base must be GTK::SpinButton compatible!'
      unless $base ~~ GTK::SpinButton;

    ReturnWidget(
      dzl_preferences_spin_button_get_spin_button($!dpsb),
       $raw,
      :$widget,
      :$base
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-spin-button.h

sub dzl_preferences_spin_button_get_spin_button (DzlPreferencesSpinButton $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_preferences_spin_button_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

# Constructed

sub new_spin_button (
  GType $type,
  Str,          Str, # Key
  Str,          Str, # Title
  Str,          Str, # SubTitle
  Str
)
  returns DzlPreferencesSpinButton
  is native(dazzle)
  is export
  is symbol('g_object_new')
{ * }

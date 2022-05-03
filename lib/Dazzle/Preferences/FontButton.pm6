use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::Bin;

use GLib::Roles::Signals::Generic;

our subset DzlPreferencesFontButtonAncestry is export of Mu
  where DzlPreferencesFontButton | GtkBinAncestry;

class Dazzle::Preferences::FontButton is GTK::Bin {
  also does GLib::Roles::Signals::Generic;

  has DzlPreferencesFontButton $!dpfb;

  submethod BUILD( :$dzl-preferences-font-button ) {
    self.setDzlPreferencesFontButton($dzl-preferences-font-button)
      if $dzl-preferences-font-button;
  }

  method setDzlPreferencesFontButton (
    DzlPreferencesFontButtonAncestry $_
  ) {
    my $to-parent;

    $!dpfb = do {
      when DzlPreferencesFontButton  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesFontButton, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesFontButton
    is also<DzlPreferencesFontButton>
  { $!dpfb }

  constant DPFB = DzlPreferencesFontButtonAncestry;

  multi method new (DPFB $dzl-preferences-font-button, :$ref = True) {
    return Nil unless $dzl-preferences-font-button;

    my $o = self.bless( :$dzl-preferences-font-button );
    $o.ref if $ref;
    $o
  }

  multi method new (
    Str() $key,
    Str() $title      = $key,
  ) {
    my $dzl-font-button = new_font_button(
      ::?CLASS.get_type,
      'key',              $key,
      'title',            $title,
      Str
    );

    $dzl-font-button ?? self.bless( :$dzl-font-button ) !! Nil;
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
    self.connect($!dpfb, 'activate');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &dzl_preferences_font_button_get_type,
      $n,
      $t
    );
  }
}

sub new_font_button (
  GType,
  Str,   Str,                  # Key
  Str,   Str,                  # Title
  Str
)
  returns DzlPreferencesFontButton
  is native(gobject)
  is export
  is symbol('g_object_new')
{ * }

sub dzl_preferences_font_button_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

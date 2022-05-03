use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::Bin;

our subset DzlPreferencesFileChooserButtonAncestry is export of Mu
  where DzlPreferencesFileChooserButton | GtkBinAncestry;

class Dazzle::Preferences::FileChooserButton is GTK::Bin {
  has DzlPreferencesFileChooserButton $!dpfcb;

  submethod BUILD( :$dzl-preferences-file-chooser-button ) {
    self.setDzlPreferencesFileChooserButton(
      $dzl-preferences-file-chooser-button
    ) if $dzl-preferences-file-chooser-button;
  }

  method setDzlPreferencesFileChooserButton (
    DzlPreferencesFileChooserButtonAncestry $_
  ) {
    my $to-parent;

    $!dpfcb = do {
      when DzlBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesFileChooserButton, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesFileChooserButton
    is also<DzlPreferencesFileChooserButton>
  { $!dpfcb }

  constant DPFCB = DzlPreferencesFileChooserButtonAncestry;

  multi method new (DPFCB $dzl-preferences-file-chooser-button, :$ref = True) {
    return Nil unless $dzl-preferences-file-chooser-button;

    my $o = self.bless( :$dzl-preferences-file-chooser-button );
    $o.ref if $ref;
    $o
  }

  multi method new (
    Int() $action,
    Str() $key,
    Str() $title      = $key,
    Str() $subtitle   = ''
  ) {
    my $dzl-file-chooser-button = new_file_chooser_button(
      ::?CLASS.get_type,
      'action',   $action,
      'key',      $key,
      'title',    $title,
      'subtitle', $subtitle,
      Str
    );

    $dzl-file-chooser-button ?? self.bless( :$dzl-file-chooser-button ) !! Nil;
  }

  # Type: GtkFileChooserAction
  method action is rw is g-property {
    my $gv = GLib::Value.new( GtkFileChooserAction );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action', $gv);
        $gv.DzlFileChooserAction;
      },
      STORE => -> $,  $val is copy {
        warn 'action is a construct-only attribute'
      }
    );
  }

  # Type: string
  method key is rw is g-property {
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
  method title is rw is g-property {
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

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &dzl_preferences_file_chooser_button_get_type,
      $n,
      $t
    );
  }
}

sub new_file_chooser_button (
  GType,
  Str,   GtkFileChooserAction, # Action
  Str,   Str,                  # Key
  Str,   Str,                  # Title
  Str,   Str,                  # Subtitle
  Str
)
  returns DzlPreferencesFileChooserButton
  is native(gobject)
  is export
  is symbol('g_object_new')
{ * }

sub dzl_preferences_file_chooser_button_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use Dazzle::Preferences::Bin;

our subset DzlPreferenceEntryAncestry is export of Mu
  where DzlPreferencesEntry | DzlPreferencesBinAncestry;

class Dazzle::Preferences::Entry is Dazzle::Preferences::Bin {
  has DzlPreferencesEntry $!dpe;

  submethod BUILD ( :$dzl-preferences-entry ) {
    self.setDzlPreferencesEntry($dzl-preferences-entry)
      if $dzl-preferences-entry
  }

  method setDzlPreferencesEntry (DzlPreferencesEntryAncestry $_) {
    my $to-parent;

    $!dpe = do {
      when DzlPreferencesEntry {
        $to-parent = cast(DzlPreferencesBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesEntry, $_);
      }
    }
    self.setDzlPreferencesBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesBin
  { $!dpe }

  multi method new (
    DzlPreferencesEntryAncestry  $dzl-preferences-entry,
                                :$ref                    = True
  ) {
    return Nil unless $dzl-preferences-entry;

    my $o = self.bless( :$dzl-preferences-entry );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-preferences-entry = GLib::Roles::Object.new_object_ptr(
      self.get_type
    );

    $dzl-preferences-entry ?? self.bless( :$dzl-preferences-entry )
                           !! Nil;
  }

  # Type: string
  method text is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: string
  method title is rw  {
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

  # SIGNALS!

  method get_entry_widget (
    :$raw    = False,
    :$widget = False,
    :$base   = GTK::Widget
  ) {
    ReturnWidget(
       dzl_preferences_entry_get_entry_widget($!dpe),
       $raw,
      :$widget,
      :$base
    );
  }

  method get_title_widget (
    :$raw    = False,
    :$widget = False,
    :$base   = GTK::Widget
  ) {
    ReturnWidget(
       dzl_preferences_entry_get_title_widget($!dpe),
       $raw,
      :$widget
      :$base,
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_preferences_entry_get_type );
  }

}

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-entry.h

sub dzl_preferences_entry_get_entry_widget (DzlPreferencesEntry $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_entry_get_title_widget (DzlPreferencesEntry $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

# cw: Inferred

sub dzl_preferences_entry_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

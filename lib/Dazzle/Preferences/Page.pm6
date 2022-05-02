use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Bin;
use Dazzle::Preferences::Group;

our subset DzlPreferencesPageAncestry is export of Mu
  where DzlPreferencesPage | GtkBinAncestry;

class Dazzle::Preferences::Page is GTK::Bin {
  has DzlPreferencesPage $!dpp is implementor;

  submethod BUILD( :$dzl-preferences-page ) {
    self.setDzlPreferencesPage($dzl-preferences-page) if $dzl-preferences-page;
  }

  method setDzlPreferencesPage (DzlPreferencesPageAncestry $_) {
    my $to-parent;

    $!dpp = do {
      when DzlPreferencesPage {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesPage, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesPage
    is also<DzlPreferencesPage>
  { $!dpp }

  method new (
    DzlPreferencesPageAncestry  $dzl-preferences-page,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-preferences-page;

    my $o = self.bless( :$dzl-preferences-page );
    $o.ref if $ref;
    $o
  }

  # Type: int
  method priority is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('priority', $gv);
      }
    );
  }

  method add_group (DzlPreferencesGroup() $group) is also<add-group> {
    dzl_preferences_page_add_group($!dpp, $group);
  }

  method get_group (Str() $group_name, :$raw = False) is also<get-group> {
    propReturnObject(
      dzl_preferences_page_get_group($!dpp, $group_name),
      $raw,
      |Dazzle::Preferences::Group.getTypePair
    );
  }

  method refilter (DzlPatternSpec() $spec) {
    dzl_preferences_page_refilter($!dpp, $spec);
  }

  method set_map (GHashTable() $map) is also<set-map> {
    dzl_preferences_page_set_map($!dpp, $map);
  }

}

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-page.h

sub dzl_preferences_page_add_group (
  DzlPreferencesPage  $self,
  DzlPreferencesGroup $group
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_page_get_group (DzlPreferencesPage $self, Str $group_name)
  returns DzlPreferencesGroup
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_page_refilter (
  DzlPreferencesPage $self,
  DzlPatternSpec     $spec
)
  is native(dazzle)
  is export
{ * }

sub dzl_preferences_page_set_map (DzlPreferencesPage $self, GHashTable $map)
  is native(dazzle)
  is export
{ * }

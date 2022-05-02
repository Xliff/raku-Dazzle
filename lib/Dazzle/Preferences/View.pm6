use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Preferences::View;

use GTK::Bin;

use Dazzle::Roles::Preferences;

our subset DzlPreferencesViewAncestry is export of Mu
  where DzlPreferencesView | DzlPreferences | GtkBinAncestry;

class Dazzle::Preferences::View is GTK::Bin {
  also does Dazzle::Roles::Preferences;

  has DzlPreferencesView $!dpv is implementor;

  submethod BUILD( :$dzl-preferences-view ) {
    self.setDzlPreferencesView($dzl-preferences-view) if $dzl-preferences-view;
  }

  method setDzlPreferencesView (DzlPreferencesViewAncestry $_) {
    my $to-parent;

    $!dpv = do {
      when DzlPreferencesView {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      when DzlPreferences {
        $to-parent = cast(GtkBin, $_);
        $!dp       = $_;
        cast(DzlPreferencesView, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesView, $_);
      }
    }
    self.setGtkBin($to-parent);
    self.roleInit-DzlPreferences;
  }

  method Dazzle::Raw::Definitions::DzlPreferencesView
    is also<DzlPreferencesView>
  { $!dpv }

  multi method new (
    DzlPreferencesViewAncestry  $dzl-preferences-view,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-preferences-view;

    my $o = self.bless( :$dzl-preferences-view );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-preferences-view = dzl_preferences_view_new();

    $dzl-preferences-view ?? self.bless( :$dzl-preferences-view ) !! Nil;
  }

  # Type: boolean
  method show-search-entry is rw  is g-property is also<show_search_entry> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-search-entry', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-search-entry', $gv);
      }
    );
  }

  # Type: boolean
  method use-sidebar is rw  is g-property is also<use_sidebar> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-sidebar', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-sidebar', $gv);
      }
    );
  }

  method get_show_search_entry is also<get-show-search-entry> {
    so dzl_preferences_view_get_show_search_entry($!dpv);
  }

  method get_use_sidebar is also<get-use-sidebar> {
    so dzl_preferences_view_get_use_sidebar($!dpv);
  }

  method reapply_filter is also<reapply-filter> {
    dzl_preferences_view_reapply_filter($!dpv);
  }

  method set_show_search_entry (Int() $show_search_entry)
    is also<set-show-search-entry>
  {
    my gboolean $s = $show_search_entry.so.Int;

    dzl_preferences_view_set_show_search_entry($!dpv, $show_search_entry);
  }

  method set_use_sidebar (Int() $use_sidebar) is also<set-use-sidebar> {
    my gboolean $u = $use_sidebar.so.Int;

    dzl_preferences_view_set_use_sidebar($!dpv, $use_sidebar);
  }

}

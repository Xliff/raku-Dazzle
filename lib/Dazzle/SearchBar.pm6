use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::SearchBar;

use GTK::SearchBar;
use GTK::Widget;

use GLib::Roles::Signals::Generic;

our subset DzlSearchBarAncestry is export of Mu
  where DzlSearchBar | GtkSearchBarAncestry;

class Dazzle::SearchBar is GTK::SearchBar {
  also does GLib::Roles::Signals::Generic;

  has DzlSearchBar $!dsb is implementor;

  submethod BUILD ( :$dzl-search-bar ) {
    self.setDzlSearchBar($dzl-search-bar) if $dzl-search-bar;
  }

  method setDzlSearchBar (DzlSearchBarAncestry $_) {
    my $to-parent;

    $!dsb = do {
      when DzlSearchBar  {
        $to-parent = cast(GtkSearchBar, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSearchBar, $_);
      }
    }
    self.setGtkSearchBar($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSearchBar
    is also<DzlSearchBar>
  { $!dsb }

  multi method new (DzlSearchBarAncestry $dzl-search-bar, :$ref = True) {
    return Nil unless $dzl-search-bar;

    my $o = self.bless( :$dzl-search-bar );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-search-bar = dzl_search_bar_new();

    $dzl-search-bar ?? self.bless( :$dzl-search-bar ) !! Nil;
  }

  # Type: boolean
  method search-mode-enabled is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('search-mode-enabled', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('search-mode-enabled', $gv);
      }
    );
  }

  # Type: boolean
  method show-close-button is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-close-button', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-close-button', $gv);
      }
    );
  }

  method activate {
    self.connect($!dsb, 'activate');
  }

  method reveal {
    self.connect($!dsb, 'reveal');
  }

  method get_entry ( :$raw = False, :$widget = False ) is also<get-entry> {
    ReturnWidget(
      dzl_search_bar_get_entry($!dsb),
      $raw,
      $widget
    );
  }

  method get_search_mode_enabled is also<get-search-mode-enabled> {
    so dzl_search_bar_get_search_mode_enabled($!dsb);
  }

  method get_show_close_button is also<get-show-close-button> {
    so dzl_search_bar_get_show_close_button($!dsb);
  }

  method set_search_mode_enabled (Int() $search_mode_enabled)
    is also<set-search-mode-enabled>
  {
    my gboolean $s = $search_mode_enabled.so.Int;

    dzl_search_bar_set_search_mode_enabled($!dsb, $s);
  }

  method set_show_close_button (Int() $show_close_button)
    is also<set-show-close-button>
  {
    my gboolean $s = $show_close_button.so.Int;

    dzl_search_bar_set_show_close_button($!dsb, $s);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_search_bar_get_type, $n, $t );
  }

}

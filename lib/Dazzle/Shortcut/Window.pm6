use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::Window;

use GLib::Roles::Signals::Generic;

our subset DzlShortcutsWindowAncestry is export of Mu
  where DzlShortcutsWindow | GtkWindowAncestry;

class Dazzle::Shortcut::Window is GTK::Window {
  also does GLib::Roles::Signals::Generic;

  has DzlShortcutsWindow $!dsw is implementor;

  submethod BUILD ( :$dzl-shortcuts-window ) {
    self.setDzlShortcutsWindow($dzl-shortcuts-window) if $dzl-shortcuts-window;
  }

  method setDzlShortcutsWindow (DzlShortcutsWindowAncestry $_) {
    my $to-parent;

    $!dsw = do {
      when DzlShortcutsWindow {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutsWindow, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutsWindow
  { $!dsw }

  multi method new (
    DzlShortcutsWindowAncestry  $dzl-shortcuts-window,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-shortcuts-window;

    my $o = self.bless( :$dzl-shortcuts-window );
    $o.ref if $ref;
    $o;
  }

  # Type: string
  method section-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('section-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('section-name', $gv);
      }
    );
  }

  # Type: string
  method view-name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view-name', $gv);
      }
    );
  }

  method close {
    self.connect($!dsw, 'close');
  }

  method search {
    self.connect($!dsw, 'search');
  }

  method get_type is static {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_shortcuts_window_get_type, $n, $t );
  }
}

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcuts-window.h

sub dzl_shortcuts_window_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

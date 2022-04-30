use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Window;

use Dazzle::Roles::Dock;
use Dazzle::Roles::Dock::Item;

our subset DzlDockWindowAncestry is export of Mu
  where DzlDockWindow | GtkWindowAncestry;

class Dazzle::Dock::Window is GTK::Window {
  also does Dazzle::Roles::Dock;
  also does Dazzle::Roles::Dock::Item;

  has DzlDockWindow $!ddw is implementor;

  submethod BUILD ( :$dzl-dock-window ) {
    self.setDzlDockWindow($dzl-dock-window) if $dzl-dock-window;
  }

  method setDzlDockWindow (DzlDockWindowAncestry $_) {
    my $to-parent;

    $!ddw = do {
      when DzlDockWindow {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockWindow, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlDockWindow
  { $!ddw }

  multi method new (DzlDockWindowAncestry $dzl-dock-window, :$ref = True) {
    return Nil unless $dzl-dock-window;

    my $o = self.bless( :$dzl-dock-window );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzz-dock-window = dzl_dock_window_new();

    $dzz-dock-window ?? self.bless( :$dzz-dock-window ) !! Nil;
  }

}

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-window.h

sub dzl_dock_window_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

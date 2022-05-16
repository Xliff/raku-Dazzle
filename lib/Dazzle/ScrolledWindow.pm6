use v6.c;

use NativeCall;
use Method::Also;

use Dazzle::Raw::Types;

use GTK::ScrolledWindow;

our subset DzlScrolledWindowAncestry is export of Mu
  where DzlScrolledWindow | GtkScrolledWindowAncestry;

class Dazzle::ScrolledWindow is GTK::ScrolledWindow {
  has DzlScrolledWindow $!dsw is implementor;

  submethod BUILD ( :$dzl-scrolled-window ) {
    self.setDzlScrolledWindow($dzl-scrolled-window) if $dzl-scrolled-window;
  }

  method setDzlScrolledWindow (DzlScrolledWindowAncestry $_) {
    my $to-parent;

    $!dsw = do {
      when DzlScrolledWindow  {
        $to-parent = cast(GtkScrolledWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlScrolledWindow, $_);
      }
    }
    self.setGtkScrolledWindow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlScrolledWindow
    is also<DzlScrolledWindow>
  { $!dsw }

  multi method new (
    DzlScrolledWindowAncestry  $dzl-scrolled-window,
                              :$ref                  = True
  ) {
    return Nil unless $dzl-scrolled-window;

    my $o = self.bless( :$dzl-scrolled-window );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-scrolled-window = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    $dzl-scrolled-window ?? self.bless( :$dzl-scrolled-window ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_scrolled_window_get_type, $n, $t );
  }
}

sub dzl_scrolled_window_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

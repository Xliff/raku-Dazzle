use v6.c;

use NativeCall;

use MONKEY-TYPING;

use Dazzle::Raw::Types;

use GDK::Window;

augment class GDK::Window {

  proto method synthesize_event_key (|)
  { * }

  multi method synthesize_event_key (Str $ch) {
    samewith($ch.ord);
  }
  multi method synthesize_event_key (Int() $ch) {
    dzl_gdk_synthesize_event_key(self.GdkWindow, $ch);
  }

  method synthesize_event_keyval (Int() $keyval) {
    my guint $k = $keyval;

    dzl_gdk_synthesize_event_keyval(self.GdkWindow, $keyval);
  }

}


### /usr/src/libdazzle-3.42.0/src/util/dzl-gdk.h

sub dzl_gdk_synthesize_event_key (GdkWindow $window, gunichar $ch)
  returns GdkEventKey
  is native(dazzle)
  is export
{ * }

sub dzl_gdk_synthesize_event_keyval (GdkWindow $window, guint $keyval)
  returns GdkEventKey
  is native(dazzle)
  is export
{ * }

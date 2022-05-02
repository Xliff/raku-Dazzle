use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Widget;
use GTK::ApplicationWindow;

our subset DzlApplicationWindowAncestry is export of Mu
  where DzlApplicationWindow | GtkApplicationWindowAncestry;

class Dazzle::ApplicationWindow is GTK::ApplicationWindow {
  has DzlApplicationWindow $!daw is implementor;

  submethod BUILD (:$dzl-application-window) {
    self.setDzlApplicationWindow($dzl-application-window)
      if $dzl-application-window;
  }

  method setDzlApplicationWindow (DzlApplicationWindowAncestry $_) {
    my $to-parent;

    $!daw = do {
      when DzlApplicationWindow {
        $to-parent = cast(GtkApplicationWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlApplicationWindow, $_);
      }
    }
    self.setGtkApplicationWindow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlApplicationWindow
  { $!daw }

  multi method new (
    DzlApplicationWindowAncestry  $dzl-application-window,
                                 :$ref                     = True
  ) {
    return Nil unless $dzl-application-window;

    my $o = self.bless( :$dzl-application-window );
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method fullscreen is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'fullscreen does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('fullscreen', $gv);
      }
    );
  }

  # Type: DzlTitlebarAnimation
  method titlebar-animation is rw  {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(DzlTitlebarAnimation) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('titlebar-animation', $gv)
        );
        DzlTitlebarAnimationEnum( $gv.valueFromEnum(DzlTitlebarAnimation) );
      },
      STORE => -> $,  $val is copy {
        warn 'titlebar-animation does not allow writing'
      }
    );
  }

  method get_fullscreen {
    so dzl_application_window_get_fullscreen($!daw);
  }

  method get_titlebar (:$raw = False, :$widget = False) {
    my $w = dzl_application_window_get_titlebar($!daw);

    return $w if $raw;

    # cw: Should probably rename this.
    GTK::Widget.CreateObject($w);
  }

  method get_titlebar_animation {
    DzlTitlebarAnimationEnum(
      dzl_application_window_get_titlebar_animation($!daw)\
    )
  }

  method get_type is static {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_application_window_get_type, $n, $t );
  }

  method set_fullscreen (Int() $fullscreen) {
    my gboolean $f = $fullscreen.so.Int;

    dzl_application_window_set_fullscreen($!daw, $f);
  }

  method set_titlebar (GtkWidget() $titlebar) {
    dzl_application_window_set_titlebar($!daw, $titlebar);
  }

}

### /usr/src/libdazzle-3.42.0/src/app/dzl-application-window.h

sub dzl_application_window_get_fullscreen (DzlApplicationWindow $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_application_window_get_titlebar (DzlApplicationWindow $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_application_window_get_titlebar_animation (DzlApplicationWindow $self)
  returns DzlTitlebarAnimation
  is native(dazzle)
  is export
{ * }

sub dzl_application_window_set_fullscreen (
  DzlApplicationWindow $self,
  gboolean             $fullscreen
)
  is native(dazzle)
  is export
{ * }

sub dzl_application_window_set_titlebar (
  DzlApplicationWindow $self,
  GtkWidget            $titlebar
)
  is native(dazzle)
  is export
{ * }

# Derived

sub dzl_application_window_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

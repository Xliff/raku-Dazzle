use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::DrawingArea;

our subset DzlProgressIconAncestry is export of Mu
  where DzlProgressIcon | GtkDrawingAreaAncestry;

class Dazzle::ProgressIcon is GTK::DrawingArea {
  has DzlProgressIcon $!dpi is implementor;

  submethod BUILD ( :$dzl-progress-icon ) {
    self.setDzlProgressIcon($dzl-progress-icon) if $dzl-progress-icon;
  }

  method setDzlProgressIcon(DzlProgressIconAncestry $_) {
    my $to-parent;

    $!dpi = do {
      when DzlProgressIcon {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlProgressIcon, $_);
      }
    }
    self.setGtkDrawingArea($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlProgressIcon
    is also<DzlProgressIcon>
  { $!dpi }

  multi method new (DzlProgressIconAncestry $dzl-progress-icon, :$ref = True) {
    return unless $dzl-progress-icon;

    my $o = self.bless( :$dzl-progress-icon );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-progress-icon = dzl_progress_icon_new();

    $dzl-progress-icon ?? self.bless( :$dzl-progress-icon ) !! Nil;
  }

  # Type: double
  method progress is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('progress', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('progress', $gv);
      }
    );
  }

  method get_progress is also<get-progress> {
    dzl_progress_icon_get_progress($!dpi);
  }

  method set_progress (Num() $progress) is also<set-progress> {
    my gdouble $p = $progress;

    dzl_progress_icon_set_progress($!dpi, $p);
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-progress-icon.h

sub dzl_progress_icon_get_progress (DzlProgressIcon $self)
  returns gdouble
  is native(dazzle)
  is export
{ * }

sub dzl_progress_icon_new ()
  returns DzlProgressIcon
  is native(dazzle)
  is export
{ * }

sub dzl_progress_icon_set_progress (DzlProgressIcon $self, gdouble $progress)
  is native(dazzle)
  is export
{ * }

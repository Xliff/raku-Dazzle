use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::ProgressButton;

use GLib::Value;
use GTK::Button;

our subset DzlProgressButtonAncestry is export of Mu
  where DzlProgressButton | GtkButtonAncestry;

class Dazzle::ProgressButton is GTK::Button {
  has DzlProgressButton $!dpb is implementor;

  has %!proxies;

  submethod BUILD ( :$dzl-progress-button ) {
    self.setDzlProgressButton($dzl-progress-button) if $dzl-progress-button;
  }

  method setDzlProgressButton(DzlProgressButtonAncestry $_) {
    my $to-parent;

    $!dpb = do {
      when DzlProgressButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlProgressButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlProgressButton
  { $!dpb }

  multi method new (DzlProgressButtonAncestry $dzl-progress-button, :$ref = True) {
    return unless $dzl-progress-button;

    my $o = self.bless( :$dzl-progress-button );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-progress-button = dzl_progress_button_new();

    $dzl-progress-button ?? self.bless( :$dzl-progress-button ) !! Nil;
  }

  # Type: uint
  method progress is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('progress', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('progress', $gv);
      }
    );
  }

  # Type: boolean
  method show-progress is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-progress', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-progress', $gv);
      }
    );
  }

  method get_progress {
    dzl_progress_button_get_progress($!dpb);
  }

  method get_show_progress {
    dzl_progress_button_get_show_progress($!dpb);
  }

  method set_progress (Int() $percentage) {
    my guint $p = $percentage;

    dzl_progress_button_set_progress($!dpb, $p);
  }

  method set_show_progress (Int() $show_progress) {
    my gboolean $s = $show_progress;

    dzl_progress_button_set_show_progress($!dpb, $show_progress);
  }


}

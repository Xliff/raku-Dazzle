use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::SimplePopover;

use GTK::Popover;

use GLib::Roles::Signals::Generic;
use Dazzle::Roles::Signals::SimplePopover;

our subset DzlSimplePopoverAncestry is export of Mu
  where DzlSimplePopover | GtkPopoverAncestry;

class Dazzle::SimplePopover is GTK::Popover {
  also does GLib::Roles::Signals::Generic;
  also does Dazzle::Roles::Signals::SimplePopover;

  has DzlSimplePopover $!dsp is implementor;

  submethod BUILD ( :$dzl-simple-popover ) {
    self.setDzlSimplePopover($dzl-simple-popover) if $dzl-simple-popover;
  }

  method setDzlSimplePopover(DzlSimplePopoverAncestry $_) {
    my $to-parent;

    $!dsp = do {
      when DzlSimplePopover {
        $to-parent = cast(GtkPopover, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSimplePopover, $_);
      }
    }
    self.setGtkPopover($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSimplePopover
    is also<DzlSimplePopover>
  { $!dsp }

  multi method new (
    DzlSimplePopoverAncestry  $dzl-simple-popover,
                             :$ref                 = True
  ) {
    return unless $dzl-simple-popover;

    my $o = self.bless( :$dzl-simple-popover );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-simple-popover = dzl_simple_popover_new();

    $dzl-simple-popover ?? self.bless( :$dzl-simple-popover ) !! Nil;
  }

  # Type: string
  method button-text is rw  is g-property is also<button_text> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('button-text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('button-text', $gv);
      }
    );
  }

  # Type: string
  method message is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('message', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('message', $gv);
      }
    );
  }

  # Type: boolean
  method ready is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('ready', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('ready', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method activated {
    self.connect-string($!dsp, 'activated');
  }

  method changed {
    self.connect($!dsp, 'changed');
  }




  method get_button_text is also<get-button-text> {
    dzl_simple_popover_get_button_text($!dsp);
  }

  method get_message is also<get-message> {
    dzl_simple_popover_get_message($!dsp);
  }

  method get_ready is also<get-ready> {
    dzl_simple_popover_get_ready($!dsp);
  }

  method get_text is also<get-text> {
    dzl_simple_popover_get_text($!dsp);
  }

  method get_title is also<get-title> {
    dzl_simple_popover_get_title($!dsp);
  }

  method set_button_text (Str() $button_text) is also<set-button-text> {
    dzl_simple_popover_set_button_text($!dsp, $button_text);
  }

  method set_message (Str() $message) is also<set-message> {
    dzl_simple_popover_set_message($!dsp, $message);
  }

  method set_ready (gboolean $ready) is also<set-ready> {
    my gboolean $r = $ready;

    dzl_simple_popover_set_ready($!dsp, $r);
  }

  method set_text (Str() $text) is also<set-text> {
    dzl_simple_popover_set_text($!dsp, $text);
  }

  method set_title (Str() $title) is also<set-title> {
    dzl_simple_popover_set_title($!dsp, $title);
  }

}

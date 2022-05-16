use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::RadioBox;

use GTK::Bin;

use GLib::Roles::Signals::Generic;

our subset DzlRadioBoxAncestry is export of Mu
  where DzlRadioBox | GtkBinAncestry;

class Dazzle::RadioBox is GTK::Bin {
  also does GLib::Roles::Signals::Generic;

  has DzlRadioBox $!drb is implementor;

  submethod BUILD ( :$dzl-radio-box ) {
    self.setDzlRadioBox($dzl-radio-box) if $dzl-radio-box;
  }

  method setDzlRadioBox (DzlRadioBoxAncestry $_) {
    my $to-parent;

    $!drb = do {
      when DzlRadioBox  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlRadioBox, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlRadioBox
    is also<DzlRadioBox>
  { $!drb }

  multi method new (DzlRadioBoxAncestry $dzl-radio-box, :$ref = True) {
    return Nil unless $dzl-radio-box;

    my $o = self.bless( :$dzl-radio-box );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-radio-box = dzl_radio_box_new();

    $dzl-radio-box ?? self.bless( :$dzl-radio-box ) !! Nil;
  }

  # Type: string
  method active-id is rw is g-property is also<active_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('active-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('active-id', $gv);
      }
    );
  }

  # Type: boolean
  method has-more is rw is g-property is also<has_more> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-more', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-more does not allow writing'
      }
    );
  }

  # Type: boolean
  method show-more is rw is g-property is also<show_more> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-more', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-more', $gv);
      }
    );
  }

  method changed {
    self.connect($!drb, 'changed');
  }

  method add_item (Str() $id, Str() $text) is also<add-item> {
    dzl_radio_box_add_item($!drb, $id, $text);
  }

  method get_active_id is also<get-active-id> {
    dzl_radio_box_get_active_id($!drb);
  }

  method remove_item (Str() $id) is also<remove-item> {
    dzl_radio_box_remove_item($!drb, $id);
  }

  method set_active_id (Str() $id) is also<set-active-id> {
    dzl_radio_box_set_active_id($!drb, $id);
  }

}

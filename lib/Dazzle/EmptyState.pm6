use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::EmptyState;

use GTK::Bin;

our subset DzlEmptyStateAncestry is export of Mu
  where DzlEmptyState | GtkBinAncestry;

class Dazzle::EmptyState is GTK::Bin {
  has DzlEmptyState $!des is implementor;

  submethod BUILD ( :$dzl-empty-state ) {
    self.setDzlEmptyState($dzl-empty-state) if $dzl-empty-state;
  }

  method setDzlEmptyState (DzlEmptyStateAncestry $_) {
    my $to-parent;

    $!des = do {
      when DzlEmptyState  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlEmptyState, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlEmptyState
    is also<DzlEmptyState>
  { $!des }

  multi method new (DzlEmptyStateAncestry $dzl-empty-state, :$ref = True) {
    return Nil unless $dzl-empty-state;

    my $o = self.bless( :$dzl-empty-state );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-empty-state = dzl_empty_state_new();

    $dzl-empty-state ?? self.bless( :$dzl-empty-state ) !! Nil;
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: int
  method pixel-size is rw  is g-property is also<pixel_size> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('pixel-size', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('pixel-size', $gv);
      }
    );
  }

  # Type: string
  method resource is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'resource does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('resource', $gv);
      }
    );
  }

  # Type: string
  method subtitle is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('subtitle', $gv);
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

  method get_icon_name is also<get-icon-name> {
    dzl_empty_state_get_icon_name($!des);
  }

  method get_subtitle is also<get-subtitle> {
    dzl_empty_state_get_subtitle($!des);
  }

  method get_title is also<get-title> {
    dzl_empty_state_get_title($!des);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    dzl_empty_state_set_icon_name($!des, $icon_name);
  }

  method set_resource (Str() $resource) is also<set-resource> {
    dzl_empty_state_set_resource($!des, $resource);
  }

  method set_subtitle (Str() $title) is also<set-subtitle> {
    dzl_empty_state_set_subtitle($!des, $title);
  }

  method set_title (Str() $title) is also<set-title> {
    dzl_empty_state_set_title($!des, $title);
  }

}

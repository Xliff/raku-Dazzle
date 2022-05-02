use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Bin;

use GLib::Roles::Signals::Generic;

our subset DzlPreferencesdBinAncestry is export of Mu
  where DzlPreferencesBin | GtkBinAncestry;

class Dazzle::Preferences::Bin is GTK::Bin {
  also does GLib::Roles::Signals::Generic;

  has DzlPreferencesBin $!dpb;

  submethod BUILD( :$dzl-preferences-bin ) {
    self.setDzlPreferencesBin($dzl-preferences-bin) if $dzl-preferences-bin;
  }

  method setDzlPreferencesBin (DzlPreferencesdBinAncestry $_) {
    my $to-parent;

    $!db = do {
      when DzlBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlBin, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlBin
    is also<DzlBin>
  { $!db }

  method new (
    DzlPreferencesdBinAncestry  $dzl-preferences-bin,
                               :$ref                  = True
  ) {
    return Nil unless $dzl-preferences-bin;

    my $o = self.bless( :$dzl-preferences-bin );
    $o.ref if $ref;
    $o
  }

  # Type: string
  method keywords is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('keywords', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'keywords is a construct-only attribute'
      }
    );
  }

  # Type: string
  method path is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('path', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'path is a construct-only attribute'
      }
    );
  }

  # Type: int
  method priority is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'priority is a construct-only attribute'
      }
    );
  }

  # Type: string
  method schema-id is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('schema-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'schema-id is a construct-only attribute'
      }
    );
  }

  method prefernces-activated {
    self.connect($!dpb, 'prefernces-activated');
  }

}

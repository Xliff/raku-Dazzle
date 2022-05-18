use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::CSSProvider;

our subset DzlCSSProviderAncestry is export of Mu
  where DzlCSSProvider | GtkCSSProviderAncestry;

class Dazzle::CSSProvider is GTK::CSSProvider {
  has DzlCSSProvider $!dcp is implementor;

  submethod BUILD ( :$dzl-css-provider, :$pod, :$priority, :$style ) {
    self.setDzlCSSProvider(
       $dzl-css-provider,
      :$pod,
      :$priority,
      :$style
    ) if $dzl-css-provider;
  }

  method setDzlCSSProvider(
    DzlCSSProviderAncestry  $_,
                           :$pod,
                           :$priority,
                           :$style,
  ) {
    my $to-parent;

    $!dcp = do {
      when DzlCSSProvider {
        $to-parent = cast(GtkCSSProvider, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlCSSProvider, $_);
      }
    }
    self.setGtkCSSProvider($to-parent, :$pod, :$priority, :$style);
  }

  method Dazzle::Raw::Definitions::DzlCSSProvider
  { $!dcp }

  proto method new (|)
  { * }

  multi method new (DzlCSSProviderAncestry $dzl-css-provider, :$ref = True) {
    return unless $dzl-css-provider;

    my $o = self.bless( :$dzl-css-provider );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()  $base-path = '.',
          :$pod,
          :$priority,
          :$style
  ) {
    my $dzl-css-provider = dzl_css_provider_new($base-path);

    $dzl-css-provider
      ?? self.bless(
           :$dzl-css-provider,
           :$pod,
           :$priority,
           :$style
         )
      !! Nil;
  }

  # Type: string
  method base-path is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('base-path', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('base-path', $gv);
      }
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/theming/dzl-css-provider.h

sub dzl_css_provider_new (Str $base_path)
  returns DzlCSSProvider
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::Path::Bar {
  has %!signals-dpb;

  #  DzlPathBar, DzlPath, DzlPathElement
  method connect-element-selected (
    $obj,
    $signal = 'element-selected',
    &handler?
  ) {
    my $hid;
    %!signals-dpb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-element-selected($obj, $signal,
        -> $, $dp, $dpe {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $dp, $dpe] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-dpb{$signal}[0].tap(&handler) with &handler;
    %!signals-dpb{$signal}[0];
  }

  #  DzlPathBar, DzlPath, DzlPathElement, GMenu
  method connect-populate-menu (
    $obj,
    $signal = 'populate-menu',
    &handler?
  ) {
    my $hid;
    %!signals-dpb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-populate-menu($obj, $signal,
        -> $, $dp, $dpe, $m {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $dp, $dpe, $m] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-dpb{$signal}[0].tap(&handler) with &handler;
    %!signals-dpb{$signal}[0];
  }

}

# DzlPathBar, DzlPath, DzlPathElement
sub g-connect-element-selected (
  Pointer $app,
  Str     $name,
          &handler (DzlPathBar, DzlPath, DzlPathElement),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlPathBar, DzlPath, DzlPathElement, GMenu
sub g-connect-populate-menu (
  Pointer $app,
  Str     $name,
          &handler (DzlPathBar, DzlPath, DzlPathElement, GMenu),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

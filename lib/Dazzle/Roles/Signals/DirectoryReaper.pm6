use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::DirectoryReaper {
  has %!signals-ddr;

  # GObject self, GFile
  method connect-file (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ddr{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-file($obj, $signal,
        -> $, $gf {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gf] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ddr{$signal}[0].tap(&handler) with &handler;
    %!signals-ddr{$signal}[0];
  }

}

# GObject *self, GFile $deleted-file
sub g-connect-file (
  Pointer $app,
  Str     $name,
          &handler (GObject, GFile),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::RecursiveFileMonitor {
  has %signals-drfm;

  # GFileMonitor, GFile, GFile, GFileMonitorEvent, gpointer
  method connect-dzl-changed (
    $obj,
    $signal = 'changed',
    &handler?
  ) {
    my $hid;
    %!signals-drfm{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-dzl-changed($obj, $signal,
        -> $, $f1, $f2, $fme {
          CATCH {
            default { $s.note($_) }
          }

          $s.emit( [self, $f1, $f2, $fme ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid ];
    };
    %!signals-drfm{$signal}[0].tap(&handler) with &handler;
    %!signals-drfm{$signal}[0];
  }

}

# GFileMonitor, GFile, GFile, GFileMonitorEvent, gpointer
sub g-connect-dzl-changed(
  Pointer $app,
  Str     $name,
          &handler (DzlRecursiveFileMonitor, GFile, GFile, GFileMonitorEvent),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

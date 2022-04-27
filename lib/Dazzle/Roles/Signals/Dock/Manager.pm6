use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::Dock::Manager {
  has %!signals-ddm;

  #  DzlDockManager self, DzlDock dock --> void
  method connect-dock (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-ddm{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-dock($obj, $signal,
        -> $, $dd {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $dd] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ddm{$signal}[0].tap(&handler) with &handler;
    %!signals-ddm{$signal}[0];
  }

}

# DzlDockManager *self,  DzlDock *dock
sub g-connect-dock (
  Pointer $app,
  Str     $name,
          &handler (DzlDockManager, DzlDock),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

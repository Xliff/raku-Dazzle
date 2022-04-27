use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::Dock::Item {
  has %!signals-ddi;

  # DzlDockManager self, DzlDockManager old_manager --> void
  method connect-manager-set (
    $obj,
    $signal = 'manager-set',
    &handler?
  ) {
    my $hid;
    %!signals-ddi{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-manager-set($obj, $signal,
        -> $, $ddm {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $ddm] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-ddi{$signal}[0].tap(&handler) with &handler;
    %!signals-ddi{$signal}[0];
  }

}

# DzlDockItem *self,  DzlDockManager *old_manager
sub g-connect-manager-set (
  Pointer $app,
  Str     $name,
          &handler (Pointer,  DzlDockManager),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

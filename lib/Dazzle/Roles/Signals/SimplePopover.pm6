use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::SimplePopover {
  has %!signals-dsp;

  #  guint position,  Str *chars,  guint n_chars --> gboolean
  method connect-insert-text (
    $obj,
    $signal = 'insert-text',
    &handler?
  ) {
    my $hid;
    %!signals-dsp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-insert-text($obj, $signal,
        -> $, $g, $s1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g, $s1, $g2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-dsp{$signal}[0].tap(&handler) with &handler;
    %!signals-dsp{$signal}[0];
  }

}

# DzlSimplePopover *self,  guint position,  Str *chars,  guint n_chars --> gboolean
sub g-connect-insert-text (
  Pointer $app,
  Str     $name,
          &handler (DzlSimplePopover, guint, Str, guint --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

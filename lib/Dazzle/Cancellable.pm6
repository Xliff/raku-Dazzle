use v6.c;

use MONKEY-TYPING;

use NativeCall;

use Dazzle::Raw::Types;

use GIO::Cancellable;

augment class GIO::Cancellable {

  method chain (GCancellable() $other, :$raw = False) {

    propReturnObject(
      dzl_cancellable_chain(self.GCancellable, $other),
      $raw,
      |self.getTypePair
    );

  }

}

sub dzl_cancellable_chain (GCancellable $self, GCancellable $other)
  returns GCancellable
  is export
  is native(dazzle)
{ * }

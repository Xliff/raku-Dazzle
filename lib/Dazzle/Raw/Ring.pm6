use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Structs;

### /usr/src/libdazzle-3.42.0/src/util/dzl-ring.h

sub dzl_ring_append_vals (
  DzlRing  $ring,
  gpointer $data,
  guint    $len
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_ring_foreach (
  DzlRing  $ring,
           &func (gpointer, gpointer),
  gpointer $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_ring_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_ring_ref (DzlRing $ring)
  returns DzlRing
  is native(dazzle)
  is export
{ * }

sub dzl_ring_sized_new (
  guint $element_size,
  guint $reserved_size,
        &element_destroy (gpointer)
)
  returns DzlRing
  is native(dazzle)
  is export
{ * }

sub dzl_ring_unref (DzlRing $ring)
  is native(dazzle)
  is export
{ * }

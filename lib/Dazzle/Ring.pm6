use v6.c;

use NativeCall;

use Dazzle::Raw::Types;
use Dazzle::Raw::Ring;

use GLib::Roles::Implementor;

class Dazzle::Ring {
  also does GLib::Roles::Implementor;

  has DzlRing $!dr is implementor;
  has         $!es;

  # cw: Add a role that accepts the type and use that to provide the
  #     positional interface.

  submethod BUILD ( :$dzl-ring, :element_size(:$element-size) ) {
    $!dr = $dzl-ring;
    $!es = $element-size;
  }

  method new (DzlRing $dzl-ring, $element-size, :$ref = True) {
    return Nil unless $dzl-ring;

    my $o = self.bless( :$dzl-ring, :$element-size );
    $o.ref if $ref;
    $o;
  }
  method sized_new (
    Int() $element_size,
    Int() $reserved_size,
          &element_destroy
  ) {
    my guint $r = $reserved_size;

    my $dzl-ring = dzl_ring_sized_new(
      $element_size,
      $reserved_size,
      &element_destroy
    );

    $dzl-ring ?? self.bless( :$dzl-ring, :$element_size ) !! Nil;
  }

  method append_vals (gpointer $data, Int() $len) {
    my guint $l = $len;

    dzl_ring_append_vals($!dr, $data, $l);
  }

  method foreach (&func, gpointer $user_data = gpointer) {
    dzl_ring_foreach($!dr, &func, $user_data);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_ring_get_type, $n, $t );
  }

  method ref {
    dzl_ring_ref($!dr);
    self;
  }

  method unref {
    dzl_ring_unref($!dr);
  }

  method index (Int() $i) {
    my gint $idx = $!dr.pos + $i;
    $idx %= $!dr.len;
    $idx += $!dr.len if $idx < 0;
    $idx -= $!dr.len if $idx > 0;
    $idx;
  }

  method get_index {
    Pointer.new( $!dr.data.p + self.index * $!es );
  }

}

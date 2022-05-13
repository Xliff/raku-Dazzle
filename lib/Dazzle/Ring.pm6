use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Ring;

use GLib::Roles::Implementor;

class Dazzle::Ring {
  also does Positional;
  also does GLib::Roles::Implementor;

  has DzlRing $!dr is implementor;

  submethod BUILD ( :$dzl-ring ) {
    $!dr = $dzl-ring;
  }

  method sized_new (Int() $reserved_size, &element_destroy) {
    my guint $r = $reserved_size;

    my $dzl-ring = dzl_ring_sized_new($reserved_size, &element_destroy);

    $dzl-ring ?? self.bless( :$dzl-ring ) !! Nil;
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
    warn 'get_index currently NYI';
  }

  method AT-POS (\k) {
    self.get_index(k)
  }

}

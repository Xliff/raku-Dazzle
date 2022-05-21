use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Fuzzy::Mutable::Index;

use GLib::Roles::Implementor;

# BOXED

class Dazzle::Fuzzy::Mutable::Index {
  also does GLib::Roles::Implementor;

  has DzlFuzzyMutableIndex $!dfmi is implementor;

  submethod BUILD ( :$dzl-fuzzy-mutable-index ) {
    $!dfmi = $dzl-fuzzy-mutable-index;
  }

  method Dazzle::Raw::Definitions::DzlFuzzyMutableIndex
  { $!dfmi }

  multi method new (
    DzlFuzzyMutableIndex  $dzl-fuzzy-mutable-index,
                         :$ref                      = True
  ) {
    return unless $dzl-fuzzy-mutable-index;

    my $o = self.bless( :$dzl-fuzzy-mutable-index );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $case_sensitive) {
    my gboolean $c = $case_sensitive.so.Int;

    my $dzl-fuzzy-mutable-index = dzl_fuzzy_mutable_index_new($c);

    $dzl-fuzzy-mutable-index ?? self.bless( :$dzl-fuzzy-mutable-index ) !! Nil;
  }

  method new_with_free_func (Int() $case_sensitive, &free_func) {
    my gboolean $c = $case_sensitive.so.Int;

    my $dzl-fuzzy-mutable-index = dzl_fuzzy_mutable_index_new_with_free_func(
      $c,
      &free_func
    );

    $dzl-fuzzy-mutable-index ?? self.bless( :$dzl-fuzzy-mutable-index ) !! Nil;
  }


  method begin_bulk_insert {
    dzl_fuzzy_mutable_index_begin_bulk_insert($!dfmi);
  }

  method contains (Str() $key) {
    dzl_fuzzy_mutable_index_contains($!dfmi, $key);
  }

  method highlight (Str() $query, Int() $case_sensitive) {
    my gboolean $c = $case_sensitive.so.Int;

    dzl_fuzzy_highlight($!dfmi, $query, $case_sensitive);
  }

  method end_bulk_insert {
    dzl_fuzzy_mutable_index_end_bulk_insert($!dfmi);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_fuzzy_mutable_index_get_type, $n, $t );
  }

  method insert (Str() $key, gpointer $value) {
    dzl_fuzzy_mutable_index_insert($!dfmi, $key, $value);
  }

  method match (
    Str()  $needle,
    Int()  $max_matches,
          :$raw          = False,
          :$array        = True
   ) {
    my gsize $m = $max_matches;
    my       $a = dzl_fuzzy_mutable_index_match($!dfmi, $needle, $max_matches);

    $a = propReturnObject($a, $raw, |GLib::Array.getTypePair);

    return $a unless $array;

    # cw: -XXX- Yes, but what about the contents of the array! We will need
    #     a returnGArray to sort that out.
    $a.Array;
  }

  method ref {
    dzl_fuzzy_mutable_index_ref($!dfmi);
    self
  }

  method remove (Str() $key) {
    dzl_fuzzy_mutable_index_remove($!dfmi, $key);
  }

  method set_free_func (&free_func) {
    dzl_fuzzy_mutable_index_set_free_func($!dfmi, &free_func);
  }

  method unref {
    dzl_fuzzy_mutable_index_unref($!dfmi);
  }

}

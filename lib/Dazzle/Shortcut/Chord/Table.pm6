use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Chord;

class Dazzle::Shortcut::Chord::Table {
  has DzlShortcutChordTable $!dsct;

  submethod BUILD ( :$dzl_shortcut_chord_table ) {
    $!dsct = $dzl_shortcut_chord_table;
  }

  method Dazzle::Raw::Definitions::DzlShortcutChordTable
  { $!dsct }

  method new {
    my $dzl_shortcut_chord_table = dzl_shortcut_chord_table_new();

    $dzl_shortcut_chord_table ?? self.bless( :$dzl_shortcut_chord_table )
                              !! Nil;
  }

  method add (DzlShortcutChord() $chord, gpointer $data = gpointer) {
    dzl_shortcut_chord_table_add($!dsct, $chord, $data);
  }

  method foreach (&foreach_func, gpointer $foreach_data = gpointer) {
    dzl_shortcut_chord_table_foreach($!dsct, &foreach_func, $foreach_data);
  }

  method free {
    dzl_shortcut_chord_table_free($!dsct);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_shortcut_chord_table_get_type, $n, $t );
  }

  method lookup (DzlShortcutChord() $chord, gpointer $data = gpointer) {
    dzl_shortcut_chord_table_lookup($!dsct, $chord, $data);
  }

  method lookup_data (gpointer $data) {
    dzl_shortcut_chord_table_lookup_data($!dsct, $data);
  }

  method printf {
    dzl_shortcut_chord_table_printf($!dsct);
  }

  method remove (DzlShortcutChord() $chord) {
    dzl_shortcut_chord_table_remove($!dsct, $chord);
  }

  method remove_data (gpointer $data) {
    dzl_shortcut_chord_table_remove_data($!dsct, $data);
  }

  method set_free_func (&notify) {
    dzl_shortcut_chord_table_set_free_func($!dsct, &notify);
  }

  method size {
    dzl_shortcut_chord_table_size($!dsct);
  }
}

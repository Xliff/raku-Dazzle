use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Chord;

use GLib::Roles::Implementor;

class Dazzle::Shortcut::Chord {
  also does GLib::Roles::Implementor;

  has DzlShortcutChord $!dsc;

  submethod BUILD ( :$dzl-shortcut-chord ) {
    $!dsc = $dzl-shortcut-chord;
  }

  method Dazzle::Raw::Definitions::DzlShortcutChord
  { $!dsc }

  method new_from_event (GdkEventKey() $event) {
    my $dzl-shortcut-chord = dzl_shortcut_chord_new_from_event($event);

    $dzl-shortcut-chord ?? self.bless( :$dzl-shortcut-chord ) !! Nil
  }

  method new_from_string (Str() $accelerator) {
    my $dzl-shortcut-chord = dzl_shortcut_chord_new_from_string($accelerator);

    $dzl-shortcut-chord ?? self.bless( :$dzl-shortcut-chord ) !! Nil
  }

  method append_event (GdkEventKey() $event) {
    dzl_shortcut_chord_append_event($!dsc, $event);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      dzl_shortcut_chord_copy($!dsc),
      $raw,
      |self.getTypePair
    );
  }

  method equal (gpointer $data1, gpointer $data2) is static {
    so dzl_shortcut_chord_equal($data1, $data2);
  }

  method free {
    dzl_shortcut_chord_free($!dsc);
  }

  method get_label {
    dzl_shortcut_chord_get_label($!dsc);
  }

  method get_length {
    dzl_shortcut_chord_get_length($!dsc);
  }

  proto method get_nth_key (|)
  { * }

  multi method get_nth_key (Int() $nth) {
    samewith($nth, $, $);
  }
  multi method get_nth_key (Int() $nth, $keyval is rw, $modifier is rw) {
    my guint           ($n, $k) = ($nth, 0);
    my GdkModifierType $m       = 0;

    dzl_shortcut_chord_get_nth_key($!dsc, $nth, $k, $m);

    ($keyval, $modifier) = ( $k, GdkModifierTypeEnum($m) )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_shortcut_chord_get_type, $n, $t );
  }

  method has_modifier {
    so dzl_shortcut_chord_has_modifier($!dsc);
  }

  method hash (gpointer $data) is static {
    dzl_shortcut_chord_hash($data);
  }

  method match (DzlShortcutChord() $other) {
    DzlShortcutMatchEnum( dzl_shortcut_chord_match($!dsc, $other) )
  }

  method to_string {
    dzl_shortcut_chord_to_string($!dsc);
  }

}

# For the enum DzlShortcutMatch
sub get_dzlshortcutmatch_type is export {
  state ($n, $t);

  unstable_get_type(
    'DzlShortcutMatch',
    &dzl_shortcut_match_get_type,
    $n,
    $t
  );
}

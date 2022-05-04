use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Structs;
use GDK::Raw::Enums;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Shortcut::Chord;

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-chord.h

sub dzl_shortcut_chord_append_event (
  DzlShortcutChord $self,
  GdkEventKey      $event
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_copy (DzlShortcutChord $self)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_match_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_equal (gconstpointer $data1, gconstpointer $data2)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_free (DzlShortcutChord $self)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_get_label (DzlShortcutChord $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_get_length (DzlShortcutChord $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_get_nth_key (
  DzlShortcutChord $self,
  guint            $nth,
  guint            $keyval   is rw,
  GdkModifierType  $modifier is rw
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_has_modifier (DzlShortcutChord $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_hash (gconstpointer $data)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_match (DzlShortcutChord $self, DzlShortcutChord $other)
  returns DzlShortcutMatch
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_new_from_event (GdkEventKey $event)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_new_from_string (Str $accelerator)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_add (
  DzlShortcutChordTable $self,
  DzlShortcutChord      $chord,
  gpointer              $data
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_foreach (
  DzlShortcutChordTable $self,
                        &foreach_func (DzlShortcutChord, gpointer, gpointer),
  gpointer              $foreach_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_free (DzlShortcutChordTable $self)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_lookup (
  DzlShortcutChordTable $self,
  DzlShortcutChord      $chord,
  gpointer              $data
)
  returns DzlShortcutMatch
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_lookup_data (
  DzlShortcutChordTable $self,
  gpointer              $data
)
  returns DzlShortcutChord
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_new ()
  returns DzlShortcutChordTable
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_printf (DzlShortcutChordTable $self)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_remove (
  DzlShortcutChordTable $self,
  DzlShortcutChord      $chord
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_remove_data (
  DzlShortcutChordTable $self,
  gpointer              $data
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_set_free_func (
  DzlShortcutChordTable $self,
                        &notify (gpointer)
)
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_table_size (DzlShortcutChordTable $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_chord_to_string (DzlShortcutChord $self)
  returns Str
  is native(dazzle)
  is export
{ * }

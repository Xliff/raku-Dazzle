use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;
use Dazzle::Raw::Structs;

unit package Dazzle::Raw::Fuzzy::Mutable::Index;

### /usr/src/libdazzle-3.42.0/src/search/dzl-fuzzy-mutable-index.h

sub dzl_fuzzy_mutable_index_begin_bulk_insert (DzlFuzzyMutableIndex $fuzzy)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_contains (DzlFuzzyMutableIndex $fuzzy, Str $key)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_highlight (Str $str, Str $query, gboolean $case_sensitive)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_end_bulk_insert (DzlFuzzyMutableIndex $fuzzy)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_insert (
  DzlFuzzyMutableIndex $fuzzy,
  Str                  $key,
  gpointer             $value
)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_match (
  DzlFuzzyMutableIndex $fuzzy,
  Str                  $needle,
  gsize                $max_matches
)
  returns GArray
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_new (gboolean $case_sensitive)
  returns DzlFuzzyMutableIndex
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_new_with_free_func (
  gboolean $case_sensitive,
           &free_func (gpointer)
)
  returns DzlFuzzyMutableIndex
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_ref (DzlFuzzyMutableIndex $fuzzy)
  returns DzlFuzzyMutableIndex
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_remove (DzlFuzzyMutableIndex $fuzzy, Str $key)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_set_free_func (
  DzlFuzzyMutableIndex $fuzzy,
                       &free_func
)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_mutable_index_unref (DzlFuzzyMutableIndex $fuzzy)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Fuzzy::Index;

### /usr/src/libdazzle-3.42.0/src/search/dzl-fuzzy-index.h

sub dzl_fuzzy_index_get_metadata (DzlFuzzyIndex $self, Str $key)
  returns GVariant
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_get_metadata_string (DzlFuzzyIndex $self, Str $key)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_get_metadata_uint32 (DzlFuzzyIndex $self, Str $key)
  returns guint32
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_get_metadata_uint64 (DzlFuzzyIndex $self, Str $key)
  returns guint64
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_load_file (
  DzlFuzzyIndex           $self,
  GFile                   $file,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_load_file_async (
  DzlFuzzyIndex $self,
  GFile         $file,
  GCancellable  $cancellable,
                &callback (DzlFuzzyIndex, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_load_file_finish (
  DzlFuzzyIndex           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_new ()
  returns DzlFuzzyIndex
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_query_async (
  DzlFuzzyIndex $self,
  Str           $query,
  guint         $max_matches,
  GCancellable  $cancellable,
                &callback (DzlFuzzyIndex, GAsyncResult, gpointer),
  gpointer      $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_query_finish (
  DzlFuzzyIndex           $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GListModel
  is native(dazzle)
  is export
{ * }

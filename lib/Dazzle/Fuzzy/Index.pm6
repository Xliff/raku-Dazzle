use v6.c;

use NativeCall;

use Dazzle::Raw::Types;
use Dazzle::Raw::Fuzzy::Index;

use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset DzlFuzzyIndexAncestry is export of Mu
  where DzlFuzzyIndex | GObject;

class Dazzle::Fuzzy::Index {
  also does GLib::Roles::Object;

  has DzlFuzzyIndex $!dfi is implementor;

  submethod BUILD (:$dzl-fuzzy-index) {
    self.setDzlFuzzyIndex($dzl-fuzzy-index) if $dzl-fuzzy-index;
  }

  method setDzlFuzzyIndex (DzlFuzzyIndexAncestry $_) {
    my $to-parent;

    $!dfi = do {
      when DzlFuzzyIndex {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlFuzzyIndex, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlFuzzyIndex
  { $!dfi }

  multi method new (DzlFuzzyIndexAncestry $dzl-fuzzy-index, :$ref = True) {
    return Nil unless $dzl-fuzzy-index;

    my $o = self.bless( :$dzl-fuzzy-index );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-fuzzy-index = dzl_fuzzy_index_new();

    $dzl-fuzzy-index ?? self.bless( :$dzl-fuzzy-index ) !! Nil;
  }

  method get_metadata (Str() $key) {
    dzl_fuzzy_index_get_metadata($!dfi, $key);
  }

  method get_metadata_string (Str() $key) {
    dzl_fuzzy_index_get_metadata_string($!dfi, $key);
  }

  method get_metadata_uint32 (Str() $key) {
    dzl_fuzzy_index_get_metadata_uint32($!dfi, $key);
  }

  method get_metadata_uint64 (Str() $key) {
    dzl_fuzzy_index_get_metadata_uint64($!dfi, $key);
  }

  proto method load_file (|)
  { * }

  multi method load_file (
    GFile()                  $file,
    CArray[Pointer[GError]]  $error       = gerror,
    GCancellable()          :$cancellable = GCancellable
  ) {
    samewith($file, $cancellable, $error)
  }
  multi method load_file (
    GFile()                 $file,
    GCancellable()          $cancellable = GCancellable,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so dzl_fuzzy_index_load_file($!dfi, $file, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method load_file_async (|)
  { * }

  multi method load_file_async (
    GFile()         $file,
                    &callback,
    gpointer        $user_data  = gpointer,
    GCancellable() $cancellable = GCancellable,
  ) {
    samewith($file, $cancellable, &callback, $user_data)
  }
  multi method load_file_async (
    GFile()        $file,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    dzl_fuzzy_index_load_file_async(
      $!dfi,
      $file,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method load_file_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = so dzl_fuzzy_index_load_file_finish($!dfi, $result, $error);
    set_error($error);
    $rv;
  }

  proto method query_async (|)
  { * }

  multi method query_async (
    Str()           $query,
    Int()           $max_matches,
                    &callback,
    gpointer        $user_data,
    GCancellable() :$cancellable   = GCancellable
  ) {
    samewith($query, $max_matches, $cancellable, &callback, $user_data)
  }

  multi method query_async (
    Str()          $query,
    Int()          $max_matches,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data
  ) {
    my guint $m = $max_matches;

    dzl_fuzzy_index_query_async(
      $!dfi,
      $query,
      $m,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method query_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw    = False
  ) {
    clear_error;
    my $l = dzl_fuzzy_index_query_finish($!dfi, $result, $error);
    set_error($error);

    propReturnObject($l, $raw, |GIO::ListModel.getTypePair);
  }

}

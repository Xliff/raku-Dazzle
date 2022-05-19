use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::DirectoryReaper;

### /usr/src/libdazzle-3.42.0/src/files/dzl-directory-reaper.h

sub dzl_directory_reaper_add_directory (
  DzlDirectoryReaper $self,
  GFile              $directory,
  GTimeSpan          $min_age
)
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_add_file (
  DzlDirectoryReaper $self,
  GFile              $file,
  GTimeSpan          $min_age
)
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_add_glob (
  DzlDirectoryReaper $self,
  GFile              $directory,
  Str                $glob,
  GTimeSpan          $min_age
)
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_execute (
  DzlDirectoryReaper      $self,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_execute_async (
  DzlDirectoryReaper $self,
  GCancellable       $cancellable,
                     &callback (DzlDirectoryReaper, GAsyncResult, gpointer),
  gpointer           $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_execute_finish (
  DzlDirectoryReaper      $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_directory_reaper_new ()
  returns DzlDirectoryReaper
  is native(dazzle)
  is export
{ * }

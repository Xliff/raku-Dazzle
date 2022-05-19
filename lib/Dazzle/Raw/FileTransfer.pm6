use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;
use Dazzle::Raw::Structs;

unit package Dazzle::Raw::FileTransfer;

### /usr/src/libdazzle-3.42.0/src/files/dzl-file-transfer.h

sub dzl_file_transfer_add (DzlFileTransfer $self, GFile $src, GFile $dest)
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_execute (
  DzlFileTransfer         $self,
  gint                    $io_priority,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_execute_async (
  DzlFileTransfer $self,
  gint            $io_priority,
  GCancellable    $cancellable,
                  &callback (DzlFileTransfer, GAsyncResult, gpointer),
  gpointer        $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_execute_finish (
  DzlFileTransfer         $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_get_flags (DzlFileTransfer $self)
  returns DzlFileTransferFlags
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_get_progress (DzlFileTransfer $self)
  returns gdouble
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_new ()
  returns DzlFileTransfer
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_set_flags (
  DzlFileTransfer      $self,
  DzlFileTransferFlags $flags
)
  is native(dazzle)
  is export
{ * }

sub dzl_file_transfer_stat (
  DzlFileTransfer     $self,
  DzlFileTransferStat $stat_buf
)
  is native(dazzle)
  is export
{ * }

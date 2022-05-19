use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::RecursiveFileMonitor;

### /usr/src/libdazzle-3.42.0/src/files/dzl-recursive-file-monitor.h

sub dzl_recursive_file_monitor_cancel (DzlRecursiveFileMonitor $self)
  is native(dazzle)
  is export
{ * }

sub dzl_recursive_file_monitor_get_root (DzlRecursiveFileMonitor $self)
  returns GFile
  is native(dazzle)
  is export
{ * }

sub dzl_recursive_file_monitor_new (GFile $root)
  returns DzlRecursiveFileMonitor
  is native(dazzle)
  is export
{ * }

sub dzl_recursive_file_monitor_set_ignore_func (
  DzlRecursiveFileMonitor $self,
                          &ignore_func (GFile, gpointer --> gboolean),
  gpointer                $ignore_func_data,
                          &ignore_func_data_destroy (gpointer)
)
  is native(dazzle)
  is export
{ * }

sub dzl_recursive_file_monitor_start_async (
  DzlRecursiveFileMonitor $self,
  GCancellable             $cancellable,
                           &callback (
                             DzlRecursiveFileMonitor,
                             GAsyncResult,
                             gpointer
                           ),
  gpointer                 $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_recursive_file_monitor_start_finish (
  DzlRecursiveFileMonitor $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(dazzle)
  is export
{ * }

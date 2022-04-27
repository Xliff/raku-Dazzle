use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::SignalGroup;

### /usr/src/libdazzle-3.42.0/src/bindings/dzl-signal-group.h

sub dzl_signal_group_block (DzlSignalGroup $self)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_connect (
  DzlSignalGroup $self,
  Str            $detailed_signal,
  Pointer        $c_handler,
  gpointer       $data
)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_connect_after (
  DzlSignalGroup $self,
  Str            $detailed_signal,
  Pointer        $c_handler,
  gpointer       $data
)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_connect_data (
  DzlSignalGroup $self,
  Str            $detailed_signal,
  Pointer        $c_handler,
  gpointer       $data,
  GClosureNotify $notify,
  GConnectFlags  $flags
)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_connect_object (
  DzlSignalGroup $self,
  Str            $detailed_signal,
  Pointer        $c_handler,
  gpointer       $object,
  GConnectFlags  $flags
)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_connect_swapped (
  DzlSignalGroup $self,
  Str            $detailed_signal,
  Pointer        $c_handler,
  gpointer       $data
)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_get_target (DzlSignalGroup $self)
  returns Pointer
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_new (GType $target_type)
  returns DzlSignalGroup
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_set_target (DzlSignalGroup $self, gpointer $target)
  is native(dazzle)
  is export
{ * }

sub dzl_signal_group_unblock (DzlSignalGroup $self)
  is native(dazzle)
  is export
{ * }

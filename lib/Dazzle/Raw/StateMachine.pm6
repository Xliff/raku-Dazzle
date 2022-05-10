use v6.c

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::StateMachine;

### /usr/src/libdazzle-3.42.0/src/statemachine/dzl-state-machine.h

sub dzl_state_machine_add_binding (
  DzlStateMachine $self,
  Str             $state,
  gpointer        $source_object,
  Str             $source_property,
  gpointer        $target_object,
  Str             $target_property,
  GBindingFlags   $flags
)
  is native(dazzle)
  is export
{ * }

# cw: varargs out of scope!
#
# sub dzl_state_machine_add_property (
#   DzlStateMachine $self,
#   Str             $state,
#   gpointer        $object,
#   Str             $property,
#   ...
# )
#   is native(dazzle)
#   is export
# { * }
#
# sub dzl_state_machine_add_property_valist (
#   DzlStateMachine $self,
#   Str             $state,
#   gpointer        $object,
#   Str             $property,
#   va_list         $var_args
# )
#   is native(dazzle)
#   is export
# { * }

sub dzl_state_machine_add_propertyv (
  DzlStateMachine $self,
  Str             $state,
  gpointer        $object,
  Str             $property,
  GValue          $value
)
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_add_style (
  DzlStateMachine $self,
  Str             $state,
  GtkWidget       $widget,
  Str             $style
)
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_connect_object (
  DzlStateMachine $self,
  Str             $state,
  gpointer        $source,
  Str             $detailed_signal,
  GCallback       $callback,
  gpointer        $user_data,
  GConnectFlags   $flags
)
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_create_action (DzlStateMachine $self, Str $name)
  returns GAction
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_get_state (DzlStateMachine $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_is_state (DzlStateMachine $self, Str $state)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_new ()
  returns DzlStateMachine
  is native(dazzle)
  is export
{ * }

sub dzl_state_machine_set_state (DzlStateMachine $self, Str $state)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::BindingGroup;

### /usr/src/libdazzle-3.42.0/src/bindings/dzl-binding-group.h

sub dzl_binding_group_bind (
  DzlBindingGroup $self,
  Str             $source_property,
  GObject         $target,
  Str             $target_property,
  GBindingFlags   $flags
)
  is native(dazzle)
  is export
{ * }

sub dzl_binding_group_bind_full (
  DzlBindingGroup $self,
  Str             $source_property,
  GObject         $target,
  Str             $target_property,
  GBindingFlags   $flags,
                  &transform_to (
                    GBinding,
                    GValue,
                    GValue,
                    gpointer
                    --> gboolean
                  ),
                  &transform_from (
                    GBinding,
                    GValue,
                    GValue,
                    gpointer
                    --> gboolean
                  ),
  gpointer        $user_data,
                  &user_data_destroy (gpointer)
)
  is native(dazzle)
  is export
{ * }

sub dzl_binding_group_bind_with_closures (
  DzlBindingGroup $self,
  Str             $source_property,
  GObject         $target,
  Str             $target_property,
  GBindingFlags   $flags,
  GClosure        $transform_to,
  GClosure        $transform_from
)
  is native(dazzle)
  is export
{ * }

sub dzl_binding_group_get_source (DzlBindingGroup $self)
  returns GObject
  is native(dazzle)
  is export
{ * }

sub dzl_binding_group_new ()
  returns DzlBindingGroup
  is native(dazzle)
  is export
{ * }

sub dzl_binding_group_set_source (DzlBindingGroup $self, GObject $source)
  is native(dazzle)
  is export
{ * }

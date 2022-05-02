use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Path;

### /usr/src/libdazzle-3.42.0/src/pathbar/dzl-path.h

sub dzl_path_append (DzlPath $self, DzlPathElement $element)
  is native(dazzle)
  is export
{ * }

sub dzl_path_get_element (DzlPath $self, guint $index)
  returns DzlPathElement
  is native(dazzle)
  is export
{ * }

sub dzl_path_get_elements (DzlPath $self)
  returns GList
  is native(dazzle)
  is export
{ * }

sub dzl_path_get_length (DzlPath $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_path_has_prefix (DzlPath $self, DzlPath $prefix)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_path_is_empty (DzlPath $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_path_new ()
  returns DzlPath
  is native(dazzle)
  is export
{ * }

sub dzl_path_prepend (DzlPath $self, DzlPathElement $element)
  is native(dazzle)
  is export
{ * }

sub dzl_path_printf (DzlPath $self)
  returns Str
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::SimpleLabel;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-simple-label.h

sub dzl_simple_label_get_label (DzlSimpleLabel $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_get_width_chars (DzlSimpleLabel $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_get_xalign (DzlSimpleLabel $self)
  returns gfloat
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_new (Str $label)
  returns DzlSimpleLabel
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_set_label (DzlSimpleLabel $self, Str $label)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_set_width_chars (DzlSimpleLabel $self, gint $width_chars)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_label_set_xalign (DzlSimpleLabel $self, gfloat $xalign)
  is native(dazzle)
  is export
{ * }

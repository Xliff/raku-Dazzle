use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::RadioBox;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-radio-box.h

sub dzl_radio_box_add_item (DzlRadioBox $self, Str $id, Str $text)
  is native(dazzle)
  is export
{ * }

sub dzl_radio_box_get_active_id (DzlRadioBox $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_radio_box_new ()
  returns DzlRadioBox
  is native(dazzle)
  is export
{ * }

sub dzl_radio_box_remove_item (DzlRadioBox $self, Str $id)
  is native(dazzle)
  is export
{ * }

sub dzl_radio_box_set_active_id (DzlRadioBox $self, Str $id)
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_radio_box_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

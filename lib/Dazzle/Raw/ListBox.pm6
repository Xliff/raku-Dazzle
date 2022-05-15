use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::ListBox;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-list-box.h

sub dzl_list_box_get_model (DzlListBox $self)
  returns GListModel
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_get_property_name (DzlListBox $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_get_row_type (DzlListBox $self)
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_new (GType $row_type, Str $property_name)
  returns DzlListBox
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_set_model (DzlListBox $self, GListModel $model)
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_set_recycle_max (DzlListBox $self, guint $recycle_max)
  is native(dazzle)
  is export
{ * }

sub dzl_list_box_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

sub dzl_list_box_row_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

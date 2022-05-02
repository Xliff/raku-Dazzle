use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::ColumnLayout;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-column-layout.h

sub dzl_column_layout_get_column_spacing (DzlColumnLayout $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_get_column_width (DzlColumnLayout $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_get_max_columns (DzlColumnLayout $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_get_row_spacing (DzlColumnLayout $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_new ()
  returns DzlColumnLayout
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_set_column_spacing (
  DzlColumnLayout $self,
  gint            $column_spacing
)
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_set_column_width (
  DzlColumnLayout $self,
  gint            $column_width
)
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_set_max_columns (
  DzlColumnLayout $self,
  guint           $max_columns
)
  is native(dazzle)
  is export
{ * }

sub dzl_column_layout_set_row_spacing (
  DzlColumnLayout $self,
  gint            $row_spacing
)
  is native(dazzle)
  is export
{ * }

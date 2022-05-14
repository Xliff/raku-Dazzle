use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::EmptyState;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-empty-state.h

sub dzl_empty_state_get_icon_name (DzlEmptyState $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_get_subtitle (DzlEmptyState $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_get_title (DzlEmptyState $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_set_icon_name (DzlEmptyState $self, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_set_resource (DzlEmptyState $self, Str $resource)
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_set_subtitle (DzlEmptyState $self, Str $title)
  is native(dazzle)
  is export
{ * }

sub dzl_empty_state_set_title (DzlEmptyState $self, Str $title)
  is native(dazzle)
  is export
{ * }

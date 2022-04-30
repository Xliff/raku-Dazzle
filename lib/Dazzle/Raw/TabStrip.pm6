use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::TabStrip;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-tab-strip.h

sub dzl_tab_strip_add_control (DzlTabStrip $self, GtkWidget $widget)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_get_edge (DzlTabStrip $self)
  returns GtkPositionType
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_get_stack (DzlTabStrip $self)
  returns GtkStack
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_get_style (DzlTabStrip $self)
  returns DzlTabStyle
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_set_edge (DzlTabStrip $self, GtkPositionType $edge)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_set_stack (DzlTabStrip $self, GtkStack $stack)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_strip_set_style (DzlTabStrip $self, DzlTabStyle $style)
  is native(dazzle)
  is export
{ * }

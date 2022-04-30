use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use GTK::Raw::Enums;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-tab.h

sub dzl_tab_get_active (DzlTab $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_can_close (DzlTab $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_edge (DzlTab $self)
  returns GtkPositionType
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_icon_name (DzlTab $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_style (DzlTab $self)
  returns DzlTabStyle
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_title (DzlTab $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_tab_get_widget (DzlTab $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_active (DzlTab $self, gboolean $active)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_can_close (DzlTab $self, gboolean $can_close)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_edge (DzlTab $self, GtkPositionType $edge)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_gicon (DzlTab $self, GIcon $gicon)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_icon_name (DzlTab $self, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_style (DzlTab $self, DzlTabStyle $style)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_title (DzlTab $self, Str $title)
  is native(dazzle)
  is export
{ * }

sub dzl_tab_set_widget (DzlTab $self, GtkWidget $widget)
  is native(dazzle)
  is export
{ * }

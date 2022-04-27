use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Menu::Button;

### /usr/src/libdazzle-3.42.0/src/menus/dzl-menu-button.h

sub dzl_menu_button_get_model (DzlMenuButton $self)
  returns GMenuModel
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_get_show_accels (DzlMenuButton $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_get_show_arrow (DzlMenuButton $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_get_show_icons (DzlMenuButton $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_new_with_model (Str $icon_name, GMenuModel $model)
  returns DzlMenuButton
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_set_model (DzlMenuButton $self, GMenuModel $model)
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_set_show_accels (
  DzlMenuButton $self,
  gboolean      $show_accels
)
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_set_show_arrow (DzlMenuButton $self, gboolean $show_arrow)
  is native(dazzle)
  is export
{ * }

sub dzl_menu_button_set_show_icons (DzlMenuButton $self, gboolean $show_icons)
  is native(dazzle)
  is export
{ * }

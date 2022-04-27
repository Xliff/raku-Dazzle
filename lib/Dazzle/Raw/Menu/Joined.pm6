use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Menu::Joined;

### /usr/src/libdazzle-3.42.0/src/menus/dzl-joined-menu.h

sub dzl_joined_menu_append_menu (DzlJoinedMenu $self, GMenuModel $model)
  is native(dazzle)
  is export
{ * }

sub dzl_joined_menu_get_n_joined (DzlJoinedMenu $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_joined_menu_new ()
  returns DzlJoinedMenu
  is native(dazzle)
  is export
{ * }

sub dzl_joined_menu_prepend_menu (DzlJoinedMenu $self, GMenuModel $model)
  is native(dazzle)
  is export
{ * }

sub dzl_joined_menu_remove_index (DzlJoinedMenu $self, guint $index)
  is native(dazzle)
  is export
{ * }

sub dzl_joined_menu_remove_menu (DzlJoinedMenu $self, GMenuModel $model)
  is native(dazzle)
  is export
{ * }

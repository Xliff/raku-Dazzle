use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Menu::Manager;

### /usr/src/libdazzle-3.42.0/src/menus/dzl-menu-manager.h

sub dzl_menu_manager_add_filename (
  DzlMenuManager          $self,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_menu_manager_add_resource (
  DzlMenuManager          $self,
  Str                     $resource,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_menu_manager_get_menu_by_id (DzlMenuManager $self, Str $menu_id)
  returns GMenu
  is native(dazzle)
  is export
{ * }

sub dzl_menu_manager_merge (
  DzlMenuManager $self,
  Str            $menu_id,
  GMenuModel     $model
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_menu_manager_new ()
  returns DzlMenuManager
  is native(dazzle)
  is export
{ * }

sub dzl_menu_manager_remove (DzlMenuManager $self, guint $merge_id)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Application;

### /usr/src/libdazzle-3.42.0/src/app/dzl-application.h

sub dzl_application_add_resources (DzlApplication $self, Str $resource_path)
  is native(dazzle)
  is export
{ * }

sub dzl_application_get_menu_by_id (DzlApplication $self, Str $menu_id)
  returns GMenu
  is native(dazzle)
  is export
{ * }

sub dzl_application_get_menu_manager (DzlApplication $self)
  returns DzlMenuManager
  is native(dazzle)
  is export
{ * }

sub dzl_application_get_shortcut_manager (DzlApplication $self)
  returns DzlShortcutManager
  is native(dazzle)
  is export
{ * }

sub dzl_application_get_theme_manager (DzlApplication $self)
  returns DzlThemeManager
  is native(dazzle)
  is export
{ * }

sub dzl_application_new (Str $application_id, GApplicationFlags $flags)
  returns DzlApplication
  is native(dazzle)
  is export
{ * }

sub dzl_application_remove_resources (DzlApplication $self, Str $resource_path)
  is native(dazzle)
  is export
{ * }

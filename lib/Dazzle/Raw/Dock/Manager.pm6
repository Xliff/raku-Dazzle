use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Dock::Manager;

### /usr/src/libdazzle-3.42.0/src/panel/dzl-dock-manager.h

sub dzl_dock_manager_new ()
  returns DzlDockManager
  is native(dazzle)
  is export
{ * }

sub dzl_dock_manager_pause_grabs (DzlDockManager $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_manager_register_dock (DzlDockManager $self, DzlDock $dock)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_manager_release_transient_grab (DzlDockManager $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_manager_unpause_grabs (DzlDockManager $self)
  is native(dazzle)
  is export
{ * }

sub dzl_dock_manager_unregister_dock (DzlDockManager $self, DzlDock $dock)
  is native(dazzle)
  is export
{ * }

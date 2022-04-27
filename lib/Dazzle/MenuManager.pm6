use v6.c;

use NativeCall;

use Dazzle::Raw::Types;
use Dazzle::Raw::MenuManager;

use GIO::Menu;

use GLib::Roles::Object;

our subset DzlMenuManagerAncestry is export of Mu
  where DzlMenuManager | GObject;

class Dazzle::MenuManager {
  also does GLib::Roles::Object;

  has DzlMenuManager $!dmm;

  submethod BUILD ( :$dzl-menu-manager ) {
    self.setDzlMenuManager($dzl-menu-manager) if $dzl-menu-manager;
  }

  method setDzlMenuManager (DzlMenuManagerAncestry $_) {
    my $to-parent;

    $!dmm = do {
      when DzlMenuManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlMenuManager, $_)
      }
    }
    self.setDzlMenuManager($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlMenuManager
  { $!dmm }

  multi method new (DzlMenuManagerAncestry $dzl-menu-manager, :$ref = True) {
    return Nil unless $dzl-menu-manager;

    my $o = self.bless( :$dzl-menu-manager );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-menu-manager = dzl_menu_manager_new();

    $dzl-menu-manager ?? self.bless( :$dzl-menu-manager ) !! Nil;
  }

  method add_filename (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    clear_error;
    my $rv = so dzl_menu_manager_add_filename($!dmm, $filename, $error);
    set_error($error);
    $rv;
  }

  method add_resource (
    Str()                   $resource,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    clear_error;
    my $rv = so dzl_menu_manager_add_resource($!dmm, $resource, $error);
    set_error($error);
    $rv;
  }

  method get_menu_by_id (Str() $menu_id, :$raw = False) {
    propReturnObject(
      dzl_menu_manager_get_menu_by_id($!dmm, $menu_id),
      $raw,
      |GIO::Menu.getTypePair
    );
  }

  method merge (Str() $menu_id, GMenuModel() $model) {
    dzl_menu_manager_merge($!dmm, $menu_id, $model);
  }

  method remove (Int() $merge_id) {
    my guint $m = $merge_id;

    dzl_menu_manager_remove($!dmm, $m);
  }

}

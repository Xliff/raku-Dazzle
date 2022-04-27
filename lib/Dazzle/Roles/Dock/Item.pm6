use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::Item;

#use Dazzle::Dock::Manager;

use GIO::Roles::Icon;

our subset DzlDockItemAncestry is export of Mu
  where DzlDockItem | GObject;

role Dazzle::Roles::Dock::Item {
  has DzlDockItem $!ddi is implementor;

  method roleInit-DzlDockItem {
    return if $!ddi;

    my \i = findProperImplementor(self.^attributes);
    $!ddi = cast( DzlDockItem, i.get_value(self) );
  }

  method Dazzle::Raw::Definitions::DzlDockItem
  { $!ddi }

  method adopt (DzlDockItem() $child) {
    so dzl_dock_item_adopt($!ddi, $child);
  }

  method close {
    so dzl_dock_item_close($!ddi);
  }

  method emit_presented {
    dzl_dock_item_emit_presented($!ddi);
  }

  method get_can_close {
    so dzl_dock_item_get_can_close($!ddi);
  }

  method get_can_minimize {
    so dzl_dock_item_get_can_minimize($!ddi);
  }

  method get_child_visible (DzlDockItem() $child) {
    so dzl_dock_item_get_child_visible($!ddi, $child);
  }

  method get_icon_name {
    dzl_dock_item_get_icon_name($!ddi);
  }

  method get_manager ( :$raw = False ) {
    propReturnObject(
      dzl_dock_item_get_manager($!ddi),
      $raw,
      |Dazzle::Dock::Manager.getTypePair
    );
  }

  method get_parent ( :$raw = False ) {
    propReturnObject(
      dzl_dock_item_get_parent($!ddi),
      $raw,
      |self.getTypePair
    );
  }

  method get_title {
    dzl_dock_item_get_title($!ddi);
  }

  method has_widgets {
    so dzl_dock_item_has_widgets($!ddi);
  }

  method minimize (DzlDockItem() $child, Int() $position) {
    my GtkPositionType $p = $position;

    dzl_dock_item_minimize($!ddi, $child, $p);
  }

  method needs_attention {
    dzl_dock_item_needs_attention($!ddi);
  }

  method present {
    dzl_dock_item_present($!ddi);
  }

  method present_child (DzlDockItem() $child) {
    dzl_dock_item_present_child($!ddi, $child);
  }

  method ref_gicon ( :$raw = False ) {
    propReturnObject(
      dzl_dock_item_ref_gicon($!ddi),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method release (DzlDockItem() $child) {
    dzl_dock_item_release($!ddi, $child);
  }

  method set_child_visible (DzlDockItem $child, gboolean $child_visible) {
    dzl_dock_item_set_child_visible($!ddi, $child, $child_visible);
  }

  method set_manager (DzlDockManager() $manager) {
    dzl_dock_item_set_manager($!ddi, $manager);
  }

  method update_visibility {
    dzl_dock_item_update_visibility($!ddi);
  }

}

class Dazzle::Dock::Item {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Dock::Item;

  submethod BUILD ( :$dzl-dock-item ) {
    self.setDzlDockItem($dzl-dock-item) if $dzl-dock-item;
  }

  method setDzlDockItem (DzlDockItemAncestry $_) {
    my $to-parent;

    $!ddi = do {
      when DzlDockItem {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockItem, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (DzlDockItemAncestry $dzl-dock-item, :$ref = True) {
    return Nil unless $dzl-dock-item;

    my $o = self.bless( :$dzl-dock-item );
    $o.ref if $ref;
    $o;
  }

}

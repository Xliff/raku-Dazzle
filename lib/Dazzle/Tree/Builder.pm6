use v6.c;

use Method::Also;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::Object;
use Dazzle::Roles::Signals::Tree::Builder;

our subset DzlTreeBuilderAncestry is export of Mu
  where DzlTreeBuilder | GObject;

class Dazzle::Tree::Builder {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Signals::Tree::Builder;

  has DzlTreeBuilder $!dtb is implementor;

  submethod BUILD (:$dzl-tree-builder) {
    self.setDzlTreeBuilder($dzl-tree-builder) if $dzl-tree-builder;
  }

  method setDzlTreeBuilder (DzlTreeBuilderAncestry $_) {
    my $to-parent;

    $!dtb = do {
      when DzlTreeBuilder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlTreeBuilder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlTreeBuilder
    is also<DzlTreeBuilder>
  { $!dtb }

  multi method new (DzlTreeBuilderAncestry $dzl-tree-builder, :$ref = True) {
    return Nil unless $dzl-tree-builder;

    my $o = self.bless( :$dzl-tree-builder );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-tree-builder = dzl_tree_builder_new();

    $dzl-tree-builder ?? self.bless( :$dzl-tree-builder ) !! Nil;
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> void
  method node-unselected is also<node_unselected> {
    self.connect-node($!dtb, 'node-unselected');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node,  GtkSelectionData *data --> gboolean
  method drag-data-get is also<drag_data_get> {
    self.connect-drag-data-get($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *drag_node,  DzlTreeBuilder *drop_node,  DzlTreeDropPosition position,  GdkDragAction action,  GtkSelectionData *data --> gboolean
  method drag-node-received is also<drag_node_received> {
    self.connect-drag-node-received($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> void
  method node-expanded is also<node_expanded> {
    self.connect-node($!dtb, 'node-expanded');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> void
  method node-selected is also<node_selected> {
    self.connect-node($!dtb, 'node-selected');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> gboolean
  method node-activated is also<node_activated> {
    self.connect-node-rbool($!dtb, 'node-activated');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  GtkWidget *tree --> void
  method added {
    self.connect-builder-widget($!dtb, 'added');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *drop_node,  DzlTreeDropPosition position,  GdkDragAction action,  GtkSelectionData *data --> gboolean
  method drag-data-received is also<drag_data_received> {
    self.connect-drag-data-received($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> gboolean
  method node-draggable is also<node_draggable> {
    self.connect-node-rbool($!dtb, 'node-draggable');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  GtkWidget *tree --> void
  method removed {
    self.connect-builder-widget($!dtb, 'removed');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *parent --> void
  method build-children is also<build_children> {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node,  GMenu *menu --> void
  method node-popup is also<node_popup> {
    self.connect-node-popup($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> void
  method build-node is also<build_node> {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> void
  method node-collapsed is also<node_collapsed> {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node,  GtkSelectionData *data --> gboolean
  method node-droppable is also<node_droppable> {
    self.connect-node-droppable($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeBuilder *node --> gboolean
  method drag-node-delete is also<drag_node_delete> {
    self.connect-node-rbool($!dtb);
  }

  method get_tree ( :$raw = False ) is also<get-tree> {
    propReturnObject(
      dzl_tree_builder_get_tree($!dtb),
      $raw,
      ::('Dazzle::Tree').getTypePair
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/tree/dzl-tree-builder.h

sub dzl_tree_builder_get_tree (DzlTreeBuilder $builder)
  returns DzlTree
  is native(dazzle)
  is export
{ * }

sub dzl_tree_builder_new ()
  returns DzlTreeBuilder
  is native(dazzle)
  is export
{ * }

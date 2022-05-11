use v6.c;

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

  method new {
    my $dzl-tree-builder = dzl_tree_builder_new();

    $dzl-tree-builder ?? self.bless( :$dzl-tree-builder ) !! Nil;
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> void
  method node-unselected {
    self.connect-node($!dtb, 'node-unselected');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node,  GtkSelectionData *data --> gboolean
  method drag-data-get {
    self.connect-drag-data-get($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *drag_node,  DzlTreeNode *drop_node,  DzlTreeDropPosition position,  GdkDragAction action,  GtkSelectionData *data --> gboolean
  method drag-node-received {
    self.connect-drag-node-received($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> void
  method node-expanded {
    self.connect-node($!dtb, 'node-expanded');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> void
  method node-selected {
    self.connect-node($!dtb, 'node-selected');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> gboolean
  method node-activated {
    self.connect-node-rbool($!dtb, 'node-activated');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  GtkWidget *tree --> void
  method added {
    self.connect-builder-widget($!dtb, 'added');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *drop_node,  DzlTreeDropPosition position,  GdkDragAction action,  GtkSelectionData *data --> gboolean
  method drag-data-received {
    self.connect-drag-data-received($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> gboolean
  method node-draggable {
    self.connect-node-rbool($!dtb, 'node-draggable');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  GtkWidget *tree --> void
  method removed {
    self.connect-builder-widget($!dtb, 'removed');
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *parent --> void
  method build-children {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node,  GMenu *menu --> void
  method node-popup {
    self.connect-node-popup($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> void
  method build-node {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> void
  method node-collapsed {
    self.connect-node($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node,  GtkSelectionData *data --> gboolean
  method node-droppable {
    self.connect-node-droppable($!dtb);
  }

  # Is originally:
  # DzlTreeBuilder *builder,  DzlTreeNode *node --> gboolean
  method drag-node-delete {
    self.connect-node-rbool($!dtb);
  }

  method get_tree ( :$raw = False ) {
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

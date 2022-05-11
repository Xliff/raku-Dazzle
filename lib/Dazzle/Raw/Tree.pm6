use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Tree;

### /usr/src/libdazzle-3.42.0/src/tree/dzl-tree.h

sub dzl_tree_add_builder (DzlTree $self, DzlTreeBuilder $builder)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_expand_to_node (DzlTree $self, DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_find_child_node (
  DzlTree     $self,
  DzlTreeNode $node,
              &find_func (
                DzlTree,
                DzlTreeNode,
                DzlTreeNode,
                gpointer
                --> gboolean
              ),
  gpointer    $user_data
)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_find_custom (
  DzlTree  $self,
           &equal_func (GObject, GObject --> gboolean),
  gpointer $key
)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_find_item (DzlTree $self, GObject $item)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_get_context_menu (DzlTree $self)
  returns GMenuModel
  is native(dazzle)
  is export
{ * }

sub dzl_tree_get_root (DzlTree $self)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_get_selected (DzlTree $self)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_get_show_icons (DzlTree $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_rebuild (DzlTree $self)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_remove_builder (DzlTree $self, DzlTreeBuilder $builder)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_scroll_to_node (DzlTree $self, DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_set_context_menu (DzlTree $self, GMenuModel $context_menu)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_set_filter (
  DzlTree  $self,
           &filter_func (DzlTree, DzlTreeNode, gpointer --> gboolean),
  gpointer $filter_data,
           &filter_data_destroy (gpointer)
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_set_root (DzlTree $self, DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_set_show_icons (DzlTree $self, gboolean $show_icons)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_unselect_all (DzlTree $self)
  is native(dazzle)
  is export
{ * }

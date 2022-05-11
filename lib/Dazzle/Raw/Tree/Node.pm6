use v6.c;

use NativeCall;

use GDK::RGBA;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GIO::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use GTK::Raw::Structs;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Tree::Node;

### /usr/src/libdazzle-3.42.0/src/tree/dzl-tree-node.h

sub dzl_tree_node_add_emblem (DzlTreeNode $self, Str $emblem_name)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_append (DzlTreeNode $node, DzlTreeNode $child)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_clear_emblems (DzlTreeNode $self)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_collapse (DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_expand (DzlTreeNode $node, gboolean $expand_ancestors)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_area (DzlTreeNode $node, GdkRectangle $area)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_children_possible (DzlTreeNode $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_expanded (DzlTreeNode $node)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_foreground_rgba (DzlTreeNode $self)
  returns GdkRGBA
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_gicon (DzlTreeNode $self)
  returns GIcon
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_icon_name (DzlTreeNode $node)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_item (DzlTreeNode $node)
  returns GObject
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_iter (DzlTreeNode $node, GtkTreeIter $iter)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_parent (DzlTreeNode $node)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_path (DzlTreeNode $node)
  returns GtkTreePath
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_reset_on_collapse (DzlTreeNode $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_text (DzlTreeNode $node)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_tree (DzlTreeNode $node)
  returns DzlTree
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_use_dim_label (DzlTreeNode $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_get_use_markup (DzlTreeNode $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_has_emblem (DzlTreeNode $self, Str $emblem_name)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_insert (
  DzlTreeNode $self,
  DzlTreeNode $child,
  guint       $position
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_insert_sorted (
  DzlTreeNode $node,
  DzlTreeNode $child,
              &compare_func (DzlTreeNode, DzlTreeNode, gpointer --> gint),
  gpointer    $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_invalidate (DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_is_root (DzlTreeNode $node)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_n_children (DzlTreeNode $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_new ()
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_nth_child (DzlTreeNode $self, guint $nth)
  returns DzlTreeNode
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_prepend (DzlTreeNode $node, DzlTreeNode $child)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_rebuild (DzlTreeNode $self)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_remove (DzlTreeNode $node, DzlTreeNode $child)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_remove_emblem (DzlTreeNode $self, Str $emblem_name)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_select (DzlTreeNode $node)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_children_possible (
  DzlTreeNode $self,
  gboolean    $children_possible
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_emblems (DzlTreeNode $self, CArray[Str] $emblems)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_foreground_rgba (
  DzlTreeNode $self,
  GdkRGBA     $foreground_rgba
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_gicon (DzlTreeNode $self, GIcon $icon)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_icon_name (DzlTreeNode $node, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_item (DzlTreeNode $node, GObject $item)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_reset_on_collapse (
  DzlTreeNode $self,
  gboolean    $reset_on_collapse
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_text (DzlTreeNode $node, Str $text)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_use_dim_label (
  DzlTreeNode $self,
  gboolean    $use_dim_label
)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_set_use_markup (DzlTreeNode $self, gboolean $use_markup)
  is native(dazzle)
  is export
{ * }

sub dzl_tree_node_show_popover (DzlTreeNode $node, GtkPopover $popover)
  is native(dazzle)
  is export
{ * }

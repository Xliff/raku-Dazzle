use v6.c;

use Method::Also;

use Dazzle::Raw::Types;
use Dazzle::Raw::Tree;

use GTK::TreeView;

our subset DzlTreeAncestry is export of Mu
  where DzlTree | GtkTreeViewAncestry;

class Dazzle::Tree is GTK::TreeView {
  has DzlTree $!dt is implementor;

  submethod BUILD (:$dzl-tree) {
    self.setDzlTree($dzl-tree) if $dzl-tree;
  }

  method setDzlTree (DzlTreeAncestry $_) {
    my $to-parent;

    $!dt = do {
      when DzlTree {
        $to-parent = cast(GtkTreeView, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlTree, $_);
      }
    }
    self.setGtkTreeView($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlTree
    is also<DzlTree>
  { $!dt }

  multi method new (DzlTreeAncestry $dzl-tree, :$ref = True) {
    return Nil unless $dzl-tree;

    my $o = self.bless( :$dzl-tree );
    $o.ref if $ref;
    $o;
  }

  method add_builder (DzlTree() $builder) is also<add-builder> {
    dzl_tree_add_builder($!dt, $builder);
  }

  method expand_to_node (DzlTreeNode() $node) is also<expand-to-node> {
    dzl_tree_expand_to_node($!dt, $node);
  }

  method find_child_node (
    DzlTreeNode $node,
                &find_func,
    gpointer    $user_data
  )
    is also<find-child-node>
  {
    dzl_tree_find_child_node($!dt, $node, &find_func, $user_data);
  }

  method find_custom (&equal_func, gpointer $key = gpointer) is also<find-custom> {
    dzl_tree_find_custom($!dt, &equal_func, $key);
  }

  method find_item (GObject() $item) is also<find-item> {
    dzl_tree_find_item($!dt, $item);
  }

  method get_context_menu is also<get-context-menu> {
    dzl_tree_get_context_menu($!dt);
  }

  method get_root is also<get-root> {
    dzl_tree_get_root($!dt);
  }

  method get_selected is also<get-selected> {
    dzl_tree_get_selected($!dt);
  }

  method get_show_icons is also<get-show-icons> {
    dzl_tree_get_show_icons($!dt);
  }

  method rebuild {
    dzl_tree_rebuild($!dt);
  }

  method remove_builder (DzlTree() $builder) is also<remove-builder> {
    dzl_tree_remove_builder($!dt, $builder);
  }

  method scroll_to_node (DzlTreeNode() $node) is also<scroll-to-node> {
    dzl_tree_scroll_to_node($!dt, $node);
  }

  method set_context_menu (GMenuModel() $context_menu)
    is also<set-context-menu>
  {
    dzl_tree_set_context_menu($!dt, $context_menu);
  }

  method set_filter (
             &filter_func,
    gpointer $filter_data,
             &filter_data_destroy
  )
    is also<set-filter>
  {
    dzl_tree_set_filter(
      $!dt,
      &filter_func,
      $filter_data,
      &filter_data_destroy
    );
  }

  method set_root (DzlTreeNode() $node) is also<set-root> {
    dzl_tree_set_root($!dt, $node);
  }

  method set_show_icons (Int() $show_icons) is also<set-show-icons> {
    my gboolean $s = $show_icons;

    dzl_tree_set_show_icons($!dt, $s);
  }

  method unselect_all is also<unselect-all> {
    dzl_tree_unselect_all($!dt);
  }

}

use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Tree::Node;

use GLib::Value;
use GDK::Rectangle;
use GTK::TreePath;

use GLib::Roles::Object;
use GIO::Roles::Icon;

our subset DzlTreeNodeAncestry is export of Mu
  where DzlTreeNode | GObject;

class Dazzle::Tree::Node {
  also does GLib::Roles::Object;

  has DzlTreeNode $!dtn is implementor;

  submethod BUILD (:$dzl-tree-node) {
    self.setDzlTreeNode($dzl-tree-node) if $dzl-tree-node;
  }

  method setDzlTreeNode (DzlTreeNodeAncestry $_) {
    my $to-parent;

    $!dtn = do {
      when DzlTreeNode {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlTreeNode, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlTreeNode
    is also<DzlTreeNode>
  { $!dtn }

  multi method new (DzlTreeNodeAncestry $dzl-tree-node, :$ref = True) {
    return Nil unless $dzl-tree-node;

    my $o = self.bless( :$dzl-tree-node );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-tree-node = dzl_tree_node_new();

    $dzl-tree-node ?? self.bless( :$dzl-tree-node ) !! Nil;
  }

  # Type: boolean
  method children-possible is rw  is g-property is also<children_possible> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'children-possible does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        warn 'children-possible does not allow writing'
      }
    );
  }

  # Type: string
  method expanded-icon-name is rw  is g-property is also<expanded_icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('expanded-icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('expanded-icon-name', $gv);
      }
    );
  }

  # Type: GIcon
  method gicon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('gicon', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $, GIcon() $val is copy {
        $gv.object = $val;
        self.prop_set('gicon', $gv);
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: GObject
  method item ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('item', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GLib::Object.getTypePair
        );
      },
      STORE => -> $, GObject() $val is copy {
        $gv.object = $val;
        self.prop_set('item', $gv);
      }
    );
  }

  # Type: DzlTreeNode
  method parent is rw  is g-property {
    my $gv = GLib::Value.new( DzlTreeNode );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('parent', $gv);
        $gv.DzlTreeNode;
      },
      STORE => -> $,  $val is copy {
        warn 'parent does not allow writing'
      }
    );
  }

  # Type: boolean
  method reset-on-collapse is rw  is g-property is also<reset_on_collapse> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('reset-on-collapse', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reset-on-collapse', $gv);
      }
    );
  }

  # Type: string
  method text is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('text', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }

  # Type: DzlTree
  method tree ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( ::('Dazzle::Tree').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tree', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('Dazzle::Tree').getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        $gv.DzlTree = $val;
        self.prop_set('tree', $gv);
      }
    );
  }

  # Type: boolean
  method use-dim-label is rw  is g-property is also<use_dim_label> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-dim-label', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-dim-label', $gv);
      }
    );
  }

  # Type: boolean
  method use-markup is rw  is g-property is also<use_markup> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('use-markup', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('use-markup', $gv);
      }
    );
  }

  method add_emblem (Str() $emblem_name) is also<add-emblem> {
    dzl_tree_node_add_emblem($!dtn, $emblem_name);
  }

  method append (DzlTreeNode() $child) {
    dzl_tree_node_append($!dtn, $child);
  }

  method clear_emblems is also<clear-emblems> {
    dzl_tree_node_clear_emblems($!dtn);
  }

  method collapse {
    dzl_tree_node_collapse($!dtn);
  }

  method expand (gboolean $expand_ancestors) {
    so dzl_tree_node_expand($!dtn, $expand_ancestors);
  }

  proto method get_area (|)
    is also<get-area>
  { * }

  multi method get_area {
    samewith( GdkRectangle.new );
  }
  multi method get_area (GdkRectangle() $area, :$raw = False) {
    dzl_tree_node_get_area($!dtn, $area);

    propReturnObject($area, $raw, |GDK::Rectangle.getTypePair);
  }

  method get_children_possible is also<get-children-possible> {
    so dzl_tree_node_get_children_possible($!dtn);
  }

  method get_expanded is also<get-expanded> {
    so dzl_tree_node_get_expanded($!dtn);
  }

  method get_foreground_rgba is also<get-foreground-rgba> {
    dzl_tree_node_get_foreground_rgba($!dtn);
  }

  method get_gicon ( :$raw = False ) is also<get-gicon> {
    propReturnObject(
      dzl_tree_node_get_gicon($!dtn),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name is also<get-icon-name> {
    dzl_tree_node_get_icon_name($!dtn);
  }

  method get_item ( :$raw = False ) is also<get-item> {
    propReturnObject(
      dzl_tree_node_get_item($!dtn),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_iter (GtkTreeIter() $iter, :$raw = False) is also<get-iter> {
    propReturnObject(
      dzl_tree_node_get_iter($!dtn, $iter),
      $raw,
      |GTK::TreeIter.getTypePair
    );
  }

  method get_parent ( :$raw = False ) is also<get-parent> {
    propReturnObject(
      dzl_tree_node_get_parent($!dtn),
      $raw,
      |self.getTypePair
    );
  }

  method get_path ( :$raw = False ) is also<get-path> {
    propReturnObject(
      dzl_tree_node_get_path($!dtn),
      $raw,
      |GTK::TreePath.getTypePair
    );
  }

  method get_reset_on_collapse is also<get-reset-on-collapse> {
    so dzl_tree_node_get_reset_on_collapse($!dtn);
  }

  method get_text is also<get-text> {
    dzl_tree_node_get_text($!dtn);
  }

  method get_tree ( :$raw = False ) is also<get-tree> {
    propReturnObject(
      dzl_tree_node_get_tree($!dtn),
      $raw,
      ::('Dazzle::Tree').getTypePair
    );
  }

  method get_use_dim_label is also<get-use-dim-label> {
    so dzl_tree_node_get_use_dim_label($!dtn);
  }

  method get_use_markup is also<get-use-markup> {
    so dzl_tree_node_get_use_markup($!dtn);
  }

  method has_emblem (Str() $emblem_name) is also<has-emblem> {
    so dzl_tree_node_has_emblem($!dtn, $emblem_name);
  }

  method insert (DzlTreeNode() $child, Int() $position) {
    my guint $p = $position;

    dzl_tree_node_insert($!dtn, $child, $p);
  }

  method insert_sorted (
    DzlTreeNode() $child,
                  &compare_func,
    gpointer      $user_data     = gpointer
  )
    is also<insert-sorted>
  {
    dzl_tree_node_insert_sorted($!dtn, $child, &compare_func, $user_data);
  }

  method invalidate {
    dzl_tree_node_invalidate($!dtn);
  }

  method is_root is also<is-root> {
    so dzl_tree_node_is_root($!dtn);
  }

  method n_children is also<n-children> {
    dzl_tree_node_n_children($!dtn);
  }

  method nth_child (Int() $nth, :$raw = False) is also<nth-child> {
    my guint $n = $nth;

    propReturnObject(
      dzl_tree_node_nth_child($!dtn, $n),
      $raw,
      |self.getTypePair
    );
  }

  method prepend (DzlTreeNode() $child) {
    dzl_tree_node_prepend($!dtn, $child);
  }

  method rebuild {
    dzl_tree_node_rebuild($!dtn);
  }

  method remove (DzlTreeNode() $child) {
    dzl_tree_node_remove($!dtn, $child);
  }

  method remove_emblem (Str() $emblem_name) is also<remove-emblem> {
    dzl_tree_node_remove_emblem($!dtn, $emblem_name);
  }

  method select {
    dzl_tree_node_select($!dtn);
  }

  method set_children_possible (Int() $children_possible)
    is also<set-children-possible>
  {
    my gboolean $c = $children_possible.so.Int;

    dzl_tree_node_set_children_possible($!dtn, $c);
  }

  proto method set_emblems (|)
    is also<set-emblems>
  { * }

  multi method set_emblems (@emblems) {
    samewith( ArrayToCArray(Str, @emblems) );
  }
  multi method set_emblems (CArray[Str] $emblems) {
    dzl_tree_node_set_emblems($!dtn, $emblems);
  }

  method set_foreground_rgba (GdkRGBA() $foreground_rgba)
    is also<set-foreground-rgba>
  {
    dzl_tree_node_set_foreground_rgba($!dtn, $foreground_rgba);
  }

  method set_gicon (GIcon() $icon) is also<set-gicon> {
    dzl_tree_node_set_gicon($!dtn, $icon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    dzl_tree_node_set_icon_name($!dtn, $icon_name);
  }

  method set_item (GObject() $item) is also<set-item> {
    dzl_tree_node_set_item($!dtn, $item);
  }

  method set_reset_on_collapse (Int() $reset_on_collapse)
    is also<set-reset-on-collapse>
  {
    my gboolean $r = $reset_on_collapse.so.Int;

    dzl_tree_node_set_reset_on_collapse($!dtn, $r);
  }

  method set_text (Str() $text) is also<set-text> {
    dzl_tree_node_set_text($!dtn, $text);
  }

  method set_use_dim_label (Int() $use_dim_label) is also<set-use-dim-label> {
    my gboolean $u = $use_dim_label.so.Int;

    dzl_tree_node_set_use_dim_label($!dtn, $u);
  }

  method set_use_markup (Int() $use_markup) is also<set-use-markup> {
    my gboolean $u = $use_markup.so.Int;

    dzl_tree_node_set_use_markup($!dtn, $u);
  }

  method show_popover (GtkPopover() $popover) is also<show-popover> {
    dzl_tree_node_show_popover($!dtn, $popover);
  }

}

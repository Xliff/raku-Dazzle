use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::ColumnLayout;

use GTK::Container;

our subset DzlColumnLayoutAncestry is export of Mu
  where DzlColumnLayout | GtkContainerAncestry;

class Dazzle::ColumnLayout is GTK::Container {
  has DzlColumnLayout $!dcl is implementor;

  submethod BUILD ( :$dzl-column-layout ) {
    self.setDzlColumnLayout($dzl-column-layout) if $dzl-column-layout;
  }

  method setDzlColumnLayout (DzlColumnLayoutAncestry $_) {
    my $to-parent;

    $!dcl = do {
      when DzlColumnLayout {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlColumnLayout, $_);
      }
    }
    self.setGtkContainer($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlColumnLayout
  { $!dcl }

  multi method new (DzlColumnLayoutAncestry $dzl-column-layout, :$ref = True) {
    return Nil unless $dzl-column-layout;

    my $o = self.bless( :$dzl-column-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-column-layout = dzl_column_layout_new();

    $dzl-column-layout ?? self.bless( :$dzl-column-layout ) !! Nil;
  }

  # Type: int
  method column-spacing is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('column-spacing', $gv);
      }
    );
  }

  # Type: int
  method column-width is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('column-width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('column-width', $gv);
      }
    );
  }

  # Type: uint
  method max-columns is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-columns', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('max-columns', $gv);
      }
    );
  }

  # Type: int
  method priority is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('priority', $gv);
      }
    );
  }

  # Type: int
  method row-spacing is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-spacing', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('row-spacing', $gv);
      }
    );
  }

  method get_column_spacing {
    dzl_column_layout_get_column_spacing($!dcl);
  }

  method get_column_width {
    dzl_column_layout_get_column_width($!dcl);
  }

  method get_max_columns {
    dzl_column_layout_get_max_columns($!dcl);
  }

  method get_row_spacing {
    dzl_column_layout_get_row_spacing($!dcl);
  }

  method set_column_spacing (Int() $column_spacing) {
    my gint $c = $column_spacing;

    dzl_column_layout_set_column_spacing($!dcl, $c);
  }

  method set_column_width (Int() $column_width) {
    my gint $c = $column_width;

    dzl_column_layout_set_column_width($!dcl, $c);
  }

  method set_max_columns (Int() $max_columns) {
    my guint $m = $max_columns;

    dzl_column_layout_set_max_columns($!dcl, $m);
  }

  method set_row_spacing (Int() $row_spacing) {
    my gint $r = $row_spacing;

    dzl_column_layout_set_row_spacing($!dcl, $r);
  }

}

use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Roles::Object;

our subset DzlGraphColumnAncestry is export of Mu
  where DzlGraphColumn | GObject;

class Dazzle::Graph::Column {
  also does GLib::Roles::Object;

  has DzlGraphColumn $!dgc;

  submethod BUILD ( :$dzl-graph-column ) {
    self.setDzlGraphColumn($dzl-graph-column) if $dzl-graph-column;
  }

  method setDzlGraphColumn (DzlGraphColumnAncestry $_) {
    my $to-parent;

    $!dgc = do {
      when DzlGraphColumn {
        $to-parent = cast(DzlGraphColumn, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlGraphColumn, $_)
      }
    }
    self.setDzlGraphColumn($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlGraphColumn
  { $!dgc }

  multi method new (DzlGraphColumnAncestry $dzl-graph-column, :$ref = True) {
    return Nil unless $dzl-graph-column;

    my $o = self.bless( :$dzl-graph-column );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $value_type) {
    my GType $v = $value_type;

    my $dzl-graph-column = dzl_graph_view_column_new($!dgc, $value_type);

    $dzl-graph-column ?? self.bless( :$dzl-graph-column ) !! Nil;
  }

  method name is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method get_name {
    dzl_graph_view_column_get_name($!dgc);
  }

  method set_name (Str() $name) {
    dzl_graph_view_column_set_name($!dgc, $name);
  }
}


### /usr/include/libdazzle-1.0/graphing/dzl-graph-column.h

sub dzl_graph_view_column_get_name (DzlGraphColumn $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_column_new (Str $name, GType $value_type)
  returns DzlGraphColumn
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_column_set_name (DzlGraphColumn $self, Str $name)
  is native(dazzle)
  is export
{ * }

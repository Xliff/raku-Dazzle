use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::DrawingArea;
use Dazzle::Graph::Model;

our subset DzlGraphViewAncestry is export of Mu
  where DzlGraphView | GtkDrawingAreaAncestry;

class Dazzle::Graph::View is GTK::DrawingArea {
  has DzlGraphView $!dgv;

  submethod BUILD ( :$dzl-graph-view ) {
    self.setDzlGraphView($dzl-graph-view) if $dzl-graph-view;
  }

  method setDzlGraphView (DzlGraphViewAncestry $_) {
    my $to-parent;

    $!dgv = do {
      when DazzleGraphView {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DazzleGraphView, $_)
      }
    }
    self.setGtkDrawingArea($to-parent);
  }

  method Dazzle::Raw::Definitions::DazzleGraphView
  { $!dgv }

  multi method new (DzlGraphViewAncestry $dzl-graph-view, :$ref = True) {
    return Nil unless $dzl-graph-view;

    my $o = self.bless( :$dzl-graph-view );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-graph-view = dzl_graph_view_new();

    $dzl-graph-view ?? self.bless( :$dzl-graph-view ) !! Nil;
  }

  method add_renderer (DzlGraphRenderer() $renderer) {
    dzl_graph_view_add_renderer($!dgv, $renderer);
  }

  method get_model ( :$raw = False ) {
    propReturnObject(
      dzl_graph_view_get_model($!dgv),
      $raw,
      |Dazzle::Graph::Model.getTypePair
    );
  }

  method set_model (DzlGraphModel() $model) {
    dzl_graph_view_set_model($!dgv, $model);
  }

}

### /usr/include/libdazzle-1.0/graphing/dzl-graph-view.h

sub dzl_graph_view_add_renderer (DzlGraphView $self, DzlGraphRenderer $renderer)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_get_model (DzlGraphView $self)
  returns DzlGraphModel
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_new ()
  returns DazzleGraphView
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_set_model (DzlGraphView $self, DzlGraphModel $model)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use Cairo;

use Dazzle::Raw::Types;

use GLib::Roles::Object;

role Dazzle::Roles::Graph::Renderer {
  has DzlGraphRenderer $!dgr is implementor;

  method roleInit-DzlGraphRenderer {
    return if $!dgr;

    my \i = findProperImplementor(self.^attributes);
    $!dgr = cast( DzlGraphRenderer, i.get_value(self) );
  }

  method Dazzle::Raw::Definitions::DzlGraphRenderer
  { $!dgr }

  method render (
    DzlGraphModel()       $table,
    Int()                 $x_begin,
    Int()                 $x_end,
    Num()                 $y_begin,
    Num()                 $y_end,
    cairo_t()             $cr,
    cairo_rectangle_int_t $area
  ) {
    my gint64  ($xb, $xe) = ($x_begin, $x_end);
    my gdouble ($yb, $ye) = ($y_begin, $y_end);

    dzl_graph_view_renderer_render(
      $!dgr,
      $table,
      $xb,
      $xe,
      $yb,
      $ye,
      $cr,
      $area
    );
  }

}

our subset DzlGraphRendererAncestry is export of Mu
  where DzlGraphRenderer | GObject;

class Dazzle::Graph::Renderer {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Graph::Renderer;

  submethod BUILD (:$dzl-graph-renderer) {
    self.setDzlGraphRenderer($dzl-graph-renderer) if $dzl-graph-renderer;
  }

  method setDzlGraphRenderer (DzlGraphRendererAncestry $_) {
    my $to-parent;

    $!dgr = do {
      where DzlGraphRenderer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlGraphRenderer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (DzlGraphRendererAncestry $dzl-graph-renderer, :$raw = True) {
    return Nil unless $dzl-graph-renderer;

    my $o = self.bless( :$dzl-graph-renderer );
    $o.ref if $ref;
    $o;
  }
}

### /usr/include/libdazzle-1.0/graphing/dzl-graph-renderer.h

sub dzl_graph_view_renderer_render (
  DzlGraphRenderer      $self,
  DzlGraphModel         $table,
  gint64                $x_begin,
  gint64                $x_end,
  gdouble               $y_begin,
  gdouble               $y_end,
  cairo_t               $cr,
  cairo_rectangle_int_t $area
)
  is native(dazzle)
  is export
{ * }

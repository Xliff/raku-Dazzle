use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GDK::RGBA;

use GLib::Roles::Object;

our subset DzlGraphLineRendererAncestry is export of Mu
  where DzlGraphLineRenderer | GObject;

class Dazzle::Graph::Line::Renderer {
  also does GLib::Roles::Object;
  also does Dazzle::Graph::Renderer;

  has DzlGraphLineRenderer $!dlr;

  submethod BUILD (:$dzl-graph-line-renderer) {
    self.setDzlGraphLineRenderer($dzl-graph-line-renderer)
      if $dzl-graph-line-renderer;
  }

  method setDzlGraphLineRenderer (DzlGraphLineRendererAncestry $_) {
    my $to-parent;

    $!dgr = do {
      where DzlGraphLineRenderer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlGraphLineRenderer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlGraphLineRenderer
  { $!dgr }

  multi method new (
    DzlGraphLineRendererAncestry  $dzl-graph-line-renderer,
                                 :$raw = True
  ) {
    return Nil unless $dzl-graph-line-renderer;

    my $o = self.bless( :$dzl-graph-line-renderer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-graph-line-renderer = dzl_graph_view_line_renderer_new();

    $dzl-graph-line-renderer ?? self.bless( :$dzl-graph-line-renderer ) !! Nil;
  }

  # Type: uint
  method column is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'column does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('column', $gv);
      }
    );
  }

  # Type: double
  method line-width is rw  {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        warn 'line-width does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('line-width', $gv);
      }
    );
  }

  # Type: string
  method stroke-color is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'stroke-color does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('stroke-color', $gv);
      }
    );
  }

  # Type: GdkRgba
  method stroke-color-rgba is rw  {
    my $gv = GLib::Value.new( GDK::RGBA.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'stroke-color-rgba does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GdkRGBA() $val is copy {
        $gv.pointer = $val;
        self.prop_set('stroke-color-rgba', $gv);
      }
    );
  }

  method get_stroke_color_rgba {
    dzl_graph_view_line_renderer_get_stroke_color_rgba($!dlr);
  }

  method set_stroke_color (Str() $stroke_color) {
    dzl_graph_view_line_renderer_set_stroke_color($!dlr, $stroke_color);
  }

  method set_stroke_color_rgba (GdkRGBA() $stroke_color_rgba) {
    dzl_graph_view_line_renderer_set_stroke_color_rgba(
      $!dlr,
      $stroke_color_rgba
    );
  }
}

### /usr/include/libdazzle-1.0/graphing/dzl-graph-line-renderer.h

sub dzl_graph_view_line_renderer_get_stroke_color_rgba (
  DzlGraphLineRenderer $self
)
  returns GdkRGBA
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_line_renderer_new ()
  returns DzlGraphLineRenderer
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_line_renderer_set_stroke_color (
  DzlGraphLineRenderer $self,
  Str                  $stroke_color
)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_line_renderer_set_stroke_color_rgba (
  DzlGraphLineRenderer $self,
  GdkRGBA              $stroke_color_rgba
)
  is native(dazzle)
  is export
{ * }

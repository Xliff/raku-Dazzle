use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use Dazzle::Graph::View;

our subset DazzleCPUGraphAncestry is export of Mu
  where DazzleCPUGraph | DzlGraphViewAncestry;

class Dazzle::Graph::CPU is Dazzle::Graph::View {
  has DazzleCPUGraph $!dgc;

  submethod BUILD ( :$dzl-cpu-graph ) {
    self.setDazzleCPUGraph($dzl-cpu-graph) if $dzl-cpu-graph;
  }

  method setDazzleCPUGraph (DazzleCPUGraphAncestry $_) {
    my $to-parent;

    $!dgc = do {
      when DazzleCPUGraph {
        $to-parent = cast(DazzleGraphView, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DazzleCPUGraph, $_)
      }
    }
    self.setDazzleGraphView($to-parent);
  }

  method Dazzle::Raw::Definitions::DazzleCPUGraph
  { $!dgc }

  method new (DazzleCPUGraphAncestry $dzl-cpu-graph, :$ref = True) {
    return Nil unless $dzl-cpu-graph;

    my $o = self.bless( :$dzl-cpu-graph );
    $o.ref if $ref;
    $o;
  }

  method new_full (Int() $timespan, Int() $max_samples) {
    my gint64 $t = $timespan;
    my guint  $m = $max_samples;

    my $dzl-cpu-graph = dzl_cpu_graph_new_full($t, $m);

    $dzl-cpu-graph ?? self.bless( :$dzl-cpu-graph ) !! Nil;
  }

}

### /usr/include/libdazzle-1.0/graphing/dzl-cpu-graph.h

sub dzl_cpu_graph_new_full (gint64 $timespan, guint $max_samples)
  returns DazzleCPUGraph
  is native(dazzle)
  is export
{ * }

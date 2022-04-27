use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Graph::Model;

use GLib::Roles::Object;

our subset DzlGraphModelAncestry is export of Mu
  where DzlGraphModel | GObject;

class Dazzle::Graph::Model {
  also does GLib::Roles::Object;

  has DzlGraphModel $!dgm is implementor;

  submethod BUILD ( :$dzl-graph-model ) {
    self.setDzlGraphModel($dzl-graph-model) if $dzl-graph-model;
  }

  method setDzlGraphModel (DzlGraphModelAncestry $_) {
    my $to-parent;

    $!dgm = do {
      when DzlGraphModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlGraphModel, $_)
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlGraphModel
  { $!dgm }

  multi method new (DzlGraphModelAncestry $dzl-graph-model, :$ref = True) {
    return Nil unless $dzl-graph-model;

    my $o = self.bless( :$dzl-graph-model );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-graph-model = dzl_graph_view_model_new();

    $dzl-graph-model ?? self.bless( :$dzl-graph-model ) !! Nil;
  }

  method add_column (DzlGraphModel() $column) {
    dzl_graph_view_model_add_column($!dgm, $column);
  }

  method get_end_time {
    dzl_graph_view_model_get_end_time($!dgm);
  }

  proto method get_iter_first (|)
  { * }

  multi method get_iter_first (:$raw = False) {
    my $i = DzlGraphModelIter.new;
    samewith($i);
    propReturnObject($i, $raw, |::('Dazzle::Graph::Model::Iter').getTypePair)
  }
  multi method get_iter_first (DzlGraphModelIter() $iter) {
    so dzl_graph_view_model_get_iter_first($!dgm, $iter);
  }

  proto method get_iter_last (|)
  { * }

  multi method get_iter_last (:$raw = False) {
    my $i = DzlGraphModelIter.new;
    samewith($i);
    propReturnObject($i, $raw, |::('Dazzle::Graph::Model::Iter').getTypePair)
  }
  multi method get_iter_last (DzlGraphModelIter() $iter) {
    so dzl_graph_view_model_get_iter_last($!dgm, $iter);
  }

  method get_max_samples {
    dzl_graph_view_model_get_max_samples($!dgm);
  }

  method get_n_columns {
    dzl_graph_view_model_get_n_columns($!dgm);
  }

  method get_timespan {
    dzl_graph_view_model_get_timespan($!dgm);
  }

  method push (DzlGraphModelIter() $iter, Int() $timestamp) {
    my gint64 $t = $timestamp;

    dzl_graph_view_model_push($!dgm, $iter, $t);
  }

  method set_max_samples (Int() $n_rows) {
    my guint $n = $n_rows;

    dzl_graph_view_model_set_max_samples($!dgm, $n);
  }

  method set_timespan (Int() $timespan) {
    my GTimeSpan $t = $timespan;

    dzl_graph_view_model_set_timespan($!dgm, $timespan);
  }

}

class Dazzle::Graph::Model::Iter {
  has DzlGraphModelIter $!dgmi;

  method Dazzle::Raw::Definitions::DzlGraphModelIter
  { $!dgmi }

  method get (Int() $first_column) {
    my gint $f = $first_column;

    dzl_graph_view_model_iter_get($!dgmi, $f);
  }

  method get_timestamp {
    dzl_graph_view_model_iter_get_timestamp($!dgmi);
  }

  proto method get_value (|)
  { * }

  multi method get_value (Int() $column, :$raw = False) {
    my $v = GValue.new;

    samewith($column, $v);
    propReturnObject($v, $raw, |GLib::Value.getTypePair);
  }
  multi method get_value (Int() $column, GValue() $value) {
    my guint $c = $column;

    dzl_graph_view_model_iter_get_value($!dgmi, $c, $value);
  }

  method next {
    so dzl_graph_view_model_iter_next($!dgmi);
  }

  method set (Int() $first_column) {
    my gint $f = $first_column;

    dzl_graph_view_model_iter_set($!dgmi, $f);
  }

  method set_value (Int() $column, GValue() $value) {
    my guint $c = $column;

    dzl_graph_view_model_iter_set_value($!dgmi, $c, $value);
  }

}

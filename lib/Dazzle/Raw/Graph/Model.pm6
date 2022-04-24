use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Structs;

unit package Dazzle::Raw::Graph::Model;

### /usr/include/libdazzle-1.0/graphing/dzl-graph-model.h

sub dzl_graph_view_model_add_column (
  DzlGraphModel  $self,
  DzlGraphColumn $column
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_end_time (DzlGraphModel $self)
  returns gint64
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_iter_first (
  DzlGraphModel     $self,
  DzlGraphModelIter $iter
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_iter_last (
  DzlGraphModel     $self,
  DzlGraphModelIter $iter
)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_max_samples (DzlGraphModel $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_n_columns (DzlGraphModel $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_get_timespan (DzlGraphModel $self)
  returns GTimeSpan
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_get (DzlGraphModelIter $iter, gint $first_column)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_get_timestamp (DzlGraphModelIter $iter)
  returns gint64
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_get_value (
  DzlGraphModelIter $iter,
  guint             $column,
  GValue            $value
)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_next (DzlGraphModelIter $iter)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_set (DzlGraphModelIter $iter, gint $first_column)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_iter_set_value (
  DzlGraphModelIter $iter,
  guint             $column,
  GValue            $value
)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_new ()
  returns DzlGraphModel
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_push (
  DzlGraphModel     $self,
  DzlGraphModelIter $iter,
  gint64            $timestamp
)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_set_max_samples (DzlGraphModel $self, guint $n_rows)
  is native(dazzle)
  is export
{ * }

sub dzl_graph_view_model_set_timespan (
  DzlGraphModel $self,
  GTimeSpan     $timespan
)
  is native(dazzle)
  is export
{ * }

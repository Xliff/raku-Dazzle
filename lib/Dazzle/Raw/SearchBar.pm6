use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::SearchBar;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-search-bar.h

sub dzl_search_bar_get_entry (DzlSearchBar $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_search_bar_get_search_mode_enabled (DzlSearchBar $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_search_bar_get_show_close_button (DzlSearchBar $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_search_bar_new ()
  returns DzlSearchBar
  is native(dazzle)
  is export
{ * }

sub dzl_search_bar_set_search_mode_enabled (
  DzlSearchBar $self,
  gboolean     $search_mode_enabled
)
  is native(dazzle)
  is export
{ * }

sub dzl_search_bar_set_show_close_button (
  DzlSearchBar $self,
  gboolean     $show_close_button
)
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_search_bar_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

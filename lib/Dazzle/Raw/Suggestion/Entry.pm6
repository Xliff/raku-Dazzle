use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Suggestion::Entry;

### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion-entry.h

sub dzl_suggestion_entry_default_position_func (
  DzlSuggestionEntry $self,
  GdkRectangle       $area,
  gboolean           $is_absolute,
  gpointer           $user_data
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_activate_on_single_click (DzlSuggestionEntry $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_compact (DzlSuggestionEntry $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_model (DzlSuggestionEntry $self)
  returns GListModel
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_popover (DzlSuggestionEntry $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_suggestion (DzlSuggestionEntry $self)
  returns DzlSuggestion
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_get_typed_text (DzlSuggestionEntry $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_hide_suggestions (DzlSuggestionEntry $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_set_activate_on_single_click (
  DzlSuggestionEntry $self,
  gboolean           $activate_on_single_click
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_set_compact (
  DzlSuggestionEntry $self,
  gboolean $compact
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_set_model (
  DzlSuggestionEntry $self,
  GListModel         $mode
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_set_position_func (
  DzlSuggestionEntry $self,
                     &func (
                       DzlSuggestionEntry,
                       GdkRectangle,
                       gboolean             is rw,
                       gpointer
                     ),
  gpointer           $func_data,
                     &func_data_destroy (gpointer)
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_set_suggestion (
  DzlSuggestionEntry $self,
  DzlSuggestion      $suggestion
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_window_position_func (
  DzlSuggestionEntry $self,
  GdkRectangle       $area,
  gboolean           $is_absolute is rw,
  gpointer           $user_data
)
  is native(dazzle)
  is export
{ * }

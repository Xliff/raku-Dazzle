use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Suggestion::Popover;

### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion-popover.h

sub dzl_suggestion_popover_activate_selected (DzlSuggestionPopover $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_get_model (DzlSuggestionPopover $self)
  returns GListModel
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_get_relative_to (DzlSuggestionPopover $self)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_get_selected (DzlSuggestionPopover $self)
  returns DzlSuggestion
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_move_by (DzlSuggestionPopover $self, gint $amount)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_popdown (DzlSuggestionPopover $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_popup (DzlSuggestionPopover $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_set_model (
  DzlSuggestionPopover $self,
  GListModel           $model
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_set_relative_to (
  DzlSuggestionPopover $self,
  GtkWidget            $widget
)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_popover_set_selected (
  DzlSuggestionPopover $self,
  DzlSuggestion        $suggestion
)
  is native(dazzle)
  is export
{ * }

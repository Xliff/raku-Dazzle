use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Suggestion;

### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion.h

sub dzl_suggestion_get_icon (DzlSuggestion $self)
  returns GIcon
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_icon_name (DzlSuggestion $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_icon_surface (DzlSuggestion $self, GtkWidget $widget)
  returns Cairo::cairo_surface_t
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_id (DzlSuggestion $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_secondary_icon (DzlSuggestion $self)
  returns GIcon
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_secondary_icon_name (DzlSuggestion $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_secondary_icon_surface (
  DzlSuggestion $self,
  GtkWidget     $widget
)
  returns Cairo::cairo_surface_t
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_subtitle (DzlSuggestion $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_get_title (DzlSuggestion $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_new ()
  returns DzlSuggestion
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_replace_typed_text (DzlSuggestion $self, Str $typed_text)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_set_icon_name (DzlSuggestion $self, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_set_id (DzlSuggestion $self, Str $id)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_set_secondary_icon_name (DzlSuggestion $self, Str $icon_name)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_set_subtitle (DzlSuggestion $self, Str $subtitle)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_set_title (DzlSuggestion $self, Str $title)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_suggest_suffix (DzlSuggestion $self, Str $typed_text)
  returns Str
  is native(dazzle)
  is export
{ * }

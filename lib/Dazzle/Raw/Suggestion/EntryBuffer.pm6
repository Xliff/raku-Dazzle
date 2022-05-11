use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::EntryBuffer;

### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion-entry-buffer.h

sub dzl_suggestion_entry_buffer_clear (DzlSuggestionEntryBuffer $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_commit (DzlSuggestionEntryBuffer $self)
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_get_suggestion (DzlSuggestionEntryBuffer $self)
  returns DzlSuggestion
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_get_typed_length (
  DzlSuggestionEntryBuffer $self
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_get_typed_text (DzlSuggestionEntryBuffer $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_new ()
  returns DzlSuggestionEntryBuffer
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_entry_buffer_set_suggestion (
  DzlSuggestionEntryBuffer $self,
  DzlSuggestion            $suggestion
)
  is native(dazzle)
  is export
{ * }

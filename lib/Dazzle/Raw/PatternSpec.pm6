use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::PatternSpec;

### /usr/src/libdazzle-3.42.0/src/search/dzl-pattern-spec.h

sub dzl_pattern_spec_get_text (DzlPatternSpec $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_pattern_spec_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_pattern_spec_match (DzlPatternSpec $self, Str $haystack)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_pattern_spec_new (Str $keywords)
  returns DzlPatternSpec
  is native(dazzle)
  is export
{ * }

sub dzl_pattern_spec_ref (DzlPatternSpec $self)
  returns DzlPatternSpec
  is native(dazzle)
  is export
{ * }

sub dzl_pattern_spec_unref (DzlPatternSpec $self)
  is native(dazzle)
  is export
{ * }

use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Roles::Object;

our subset DzlFuzzyIndexMatchAncestry is export of Mu
  when DzlFuzzyIndexMatch | GObject;

class Dazzle::Fuzzy::Index::Match {
  also does GLib::Roles::Object;

  has DzlFuzzyIndexMatch $!dfim is implementor;

  submethod BUILD (:$dzl-fuzzy-index-match) {
    self.setDzlFuzzyIndexMatch($dzl-fuzzy-index-match)
      if $dzl-fuzzy-index-match;
  }

  method setDzlFuzzyIndexMatch (DzlFuzzyIndexMatchAncestry $_) {
    my $to-parent;

    $!dfim = do {
      when DzlFuzzyIndexMatch {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlFuzzyIndexMatch, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlFuzzyIndexMatch
  { $!dfim }

  multi method new (
    DzlFuzzyIndexMatchAncestry  $dzl-fuzzy-index-match,
                               :$ref                    = True
  ) {
    return Nil unless $dzl-fuzzy-index-match;

    my $o = self.bless( :$dzl-fuzzy-index-match );
    $o.ref if $ref;
    $o;
  }
  multi method new ($document, $key, $priority, $score) {
    my $dzl-fuzzy-index-match = dzl_fuzzy_index_match_new(
      ::?CLASS.get_type,
      'document',        $document,
      'key',             $key,
      'priority',        $priority,
      'score',           $score,
      Str
    );

    $dzl-fuzzy-index-match ?? self.bless( :$dzl-fuzzy-index-match ) !! Nil;
  }

  method new-with-properties (
    :$document   = GVariant,
    :$key        = '',
    :$priority   = 0,
    :$score      = 0e0
  ) {
    self.new($document, $key, $priority, $score);
  }

  method get_document {
    dzl_fuzzy_index_match_get_document($!dfim);
  }

  method get_key {
    dzl_fuzzy_index_match_get_key($!dfim);
  }

  method get_priority {
    dzl_fuzzy_index_match_get_priority($!dfim);
  }

  method get_score {
    dzl_fuzzy_index_match_get_score($!dfim);
  }

  method get_type is static {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_fuzzy_index_match_get_type, $n, $t )
  }

}


### /usr/src/libdazzle-3.42.0/src/search/dzl-fuzzy-index-match.h

sub dzl_fuzzy_index_match_get_document (DzlFuzzyIndexMatch $self)
  returns GVariant
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_match_get_key (DzlFuzzyIndexMatch $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_match_get_priority (DzlFuzzyIndexMatch $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_match_get_score (DzlFuzzyIndexMatch $self)
  returns gfloat
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_fuzzy_index_match_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_fuzzy_index_match_new (
  GType,
  Str,   GVariant,
  Str,   Str,
  Str,   gint,
  Str,   gfloat,
  Str
)
  returns DzlFuzzyIndexMatch
  is native(gobject)
  is export
  is symbol('g_object_new')
{ * }

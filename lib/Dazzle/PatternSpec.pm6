use v6.c;

use Dazzle::Raw::Types;

# BOXED

class Dazzle::PatternSpec {
  has DzlPatternSpec $!dps;

  submethod BUILD ( :$dzl-pattern-spec ) {
    $!dps = $dzl-pattern-spec;
  }

  method Dazzle::Raw::Definitions::DzlPatternSpec
  { $!dps }

  multi method new (DzlPatternSpec $dzl-pattern-spec, :$ref = True) {
    return Nil unless $dzl-pattern-spec;

    my $o = self.bless( :$dzl-pattern-spec );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-pattern-spec = dzl_pattern_spec_new();

    $dzl-pattern-spec ?? self.bless( :$dzl-pattern-spec ) !! Nil;
  }

  method get_text {
    dzl_pattern_spec_get_text($!dps);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_pattern_spec_get_type, $n, $t );
  }

  method match (Str() $haystack) {
    so dzl_pattern_spec_match($!dps, $haystack);
  }

  method ref {
    dzl_pattern_spec_ref($!dps);
    self;
  }

  method unref {
    dzl_pattern_spec_unref($!dps);
  }

}

use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use Dazzle::ListBox;
use Dazzle::Suggestion;

use GTK::Roles::Orientable;

our subset DzlSuggestionRowAncestry is export of Mu
  where DzlSuggestionRow | GtkOrientable | DzlListBoxRowAncestry;

class Dazzle::Suggestion::Row is Dazzle::ListBox::Row {
  also does GTK::Roles::Orientable;

  has DzlSuggestionRow $!dsr is implementor;

  submethod BUILD ( :$dzl-suggestion-row ) {
    self.setDzlSuggestionRow($dzl-suggestion-row) if $dzl-suggestion-row;
  }

  method setDzlSuggestionRow (DzlSuggestionRowAncestry $_) {
    my $to-parent;

    $!dsr = do {
      when DzlSuggestionRow  {
        $to-parent = cast(DzlListBoxRow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestionRow, $_);
      }
    }
    self.setDzlListBoxRow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestionRow
    is also<DzlSuggestionRow>
  { $!dsr }

  multi method new (
    DzlSuggestionRowAncestry  $dzl-suggestion-row,
                             :$ref                 = True
  ) {
    return Nil unless $dzl-suggestion-row;

    my $o = self.bless( :$dzl-suggestion-row );
    $o.ref if $ref;
    $o
  }

  multi method new {
    my $dzl-suggestion-row = dzl_suggestion_row_new();

    $dzl-suggestion-row ?? self.bless( :$dzl-suggestion-row ) !! Nil;
  }

  # Type: DzlSuggestion
  method suggestion is rw  is g-property {
    my $gv = GLib::Value.new( DzlSuggestion );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('suggestion', $gv);
        $gv.DzlSuggestion;
      },
      STORE => -> $,  $val is copy {
        $gv.DzlSuggestion = $val;
        self.prop_set('suggestion', $gv);
      }
    );
  }

  method get_suggestion ( :$raw = False ) is also<get-suggestion> {
    propReturnObject(
      dzl_suggestion_row_get_suggestion($!dsr),
      $raw,
      |Dazzle::Suggestion.getTypePair
    );
  }

  method set_suggestion (DzlSuggestion() $suggestion) is also<set-suggestion> {
    dzl_suggestion_row_set_suggestion($!dsr, $suggestion);
  }

}


### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion-row.h

sub dzl_suggestion_row_get_suggestion (DzlSuggestionRow $self)
  returns DzlSuggestion
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_row_new ()
  returns DzlSuggestionRow
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_row_set_suggestion (
  DzlSuggestionRow $self,
  DzlSuggestion    $suggestion
)
  is native(dazzle)
  is export
{ * }

use v6.c;

use Method::Also;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Button;
use GTK::Widget;

our subset DzlSuggestionButtonAncestry is export of Mu
  where DzlSuggestionButton | GtkButtonAncestry;

class Dazzle::Suggestion::Button is GTK::Button {
  has DzlSuggestionButton $!dsb is implementor;

  submethod BUILD ( :$dzl-suggestion-button ) {
    self.setDzlSuggestionButton($dzl-suggestion-button)
      if $dzl-suggestion-button
  }

  method setDzlSuggestionButton (DzlSuggestionButtonAncestry $_) {
    my $to-parent;

    $!dsb = do {
      when DzlSuggestionButton {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestionButton, $_);
      }
    }
    self.setGtkButton($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestionButton
    is also<DazzleSuggestionButton>
  { $!dsb }

  multi method new (
    DzlSuggestionButtonAncestry  $dzl-suggestion-button,
                                :$ref                    = True
  ) {
    return Nil unless $dzl-suggestion-button;

    my $o = self.bless( :$dzl-suggestion-button );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-suggestion-button = dzl_suggestion_button_new();

    $dzl-suggestion-button ?? self.bless( :$dzl-suggestion-button ) !! Nil;
  }

  method get_button ( :$raw = False, :$widget = False ) is also<get-button> {
    ReturnWidget(
      dzl_suggestion_button_get_button($!dsb),
      $raw,
      $widget,
      base      => GTK::Button
    );
  }

  method get_entry ( :$raw = False ) is also<get-entry> {
    propReturnObject(
      dzl_suggestion_button_get_entry($!dsb),
      $raw,
      |Dazzle::Suggestion::Entry.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_suggestion_button_get_type, $n, $t );
  }

}


### /usr/src/libdazzle-3.42.0/src/suggestions/dzl-suggestion-button.h

sub dzl_suggestion_button_get_button (DzlSuggestionButton $self)
  returns GtkButton
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_button_get_entry (DzlSuggestionButton $self)
  returns DzlSuggestionEntry
  is native(dazzle)
  is export
{ * }

sub dzl_suggestion_button_new ()
  returns DzlSuggestionButton
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_suggestion_button_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

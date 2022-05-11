use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Suggestion::EntryBuffer;

use GTK::EntryBuffer;

our subset DzlSuggestionEntryBufferAncestry is export of Mu
  where DzlSuggestionEntryBuffer | GtkEntryBufferAncestry;

class Dazzle::Suggestion::EntryBuffer is GTK::EntryBuffer {
  has DzlSuggestionEntryBuffer $!dseb is implementor;

  submethod BUILD ( :$dzl-suggestion-entry-buffer ) {
    self.setDzlSuggestionEntryBuffer($dzl-suggestion-entry-buffer)
      if $dzl-suggestion-entry-buffer;
  }

  method setDzlSuggestionPopov80er (DzlSuggestionEntryBufferAncestry $_) {
    my $to-parent;

    $!dseb = do {
      when DzlSuggestionEntryBuffer {
        $to-parent = cast(GtkEntryBuffer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestionEntryBuffer, $_);
      }
    }
    self.setGtkEntryBuffer($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestionEntryBuffer
  { $!dseb }

  multi method new (
    DzlSuggestionEntryBufferAncestry  $dzl-suggestion-entry-buffer,
                                     :$ref                          = True
  ) {
    return Nil unless $dzl-suggestion-entry-buffer;

    my $o = self.bless( :$dzl-suggestion-entry-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-suggestion-entry-buffer = dzl_suggestion_entry_buffer_new();

    $dzl-suggestion-entry-buffer ?? self.bless( :$dzl-suggestion-entry-buffer )
                                 !! Nil;
  }

  # Type: DzlSuggestion
  method suggestion ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( Dazzle::Suggestion.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('suggestion', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Suggestion.getTypePair
        );
      },
      STORE => -> $, DzlSuggestion() $val is copy {
        $gv.object = $val;
        self.prop_set('suggestion', $gv);
      }
    );
  }

  method clear {
    dzl_suggestion_entry_buffer_clear($!dseb);
  }

  method commit {
    dzl_suggestion_entry_buffer_commit($!dseb);
  }

  method get_suggestion ( :$raw = False ) {
    propReturnObject(
      dzl_suggestion_entry_buffer_get_suggestion($!dseb),
      $raw,
      |Dazzle::Suggestion.getTypePair
    );
  }

  method get_typed_length {
    dzl_suggestion_entry_buffer_get_typed_length($!dseb);
  }

  method get_typed_text {
    dzl_suggestion_entry_buffer_get_typed_text($!dseb);
  }

  method set_suggestion (DzlSuggestion() $suggestion) {
    dzl_suggestion_entry_buffer_set_suggestion($!dseb, $suggestion);
  }

}

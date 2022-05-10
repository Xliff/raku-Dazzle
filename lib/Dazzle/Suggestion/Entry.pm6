use v6.c;

use Method::Also;

use Dazzle::Raw::Types;
use Dazzle::Raw::Suggestion::Entry;

use GTK::Entry;
use Dazzle::Suggestion;
use Dazzle::Suggestion::Popover;

our subset DzlSuggestionEntryAncestry is export of Mu
  where DzlSuggestionEntry | GtkEntryAncestry;

class Dazzle::Suggestion::Entry is GTK::Entry {
  has DzlSuggestionEntry $!dse is implementor;

  submethod BUILD ( :$dzl-suggestion-entry ) {
    self.setDzlSuggestionEntry($dzl-suggestion-entry) if $dzl-suggestion-entry;
  }

  method setDzlSuggestionEntry (DzlSuggestionEntryAncestry $_) {
    my $to-parent;

    $!dse = do {
      when DzlSuggestionEntry  {
        $to-parent = cast(GtkEntry, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestionEntry, $_);
      }
    }
    self.setGtkEntry($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestionEntry
    is also<DzlSuggestionEntry>
  { $!dse }

  multi method new (
    DzlSuggestionEntryAncestry  $dzl-suggestion-entry,
                               :$ref                    = True
  ) {
    return Nil unless $dzl-suggestion-entry;

    my $o = self.bless( :$dzl-suggestion-entry );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-suggestion-entry = dzl_suggestion_entry_new();

    $dzl-suggestion-entry ?? self.bless( :$dzl-suggestion-entry ) !! Nil;
  }

  proto method default_position_func (|)
    is also<default-position-func>
  { * }

  multi method default_position_func (
    gpointer  $user_data = gpointer,
             :$area      = GdkRectangle.new
  ) {
    samewith($, $area, $);
  }
  multi method default_position_func (
    GdkRectangle() $area,
                   $is_absolute is rw,
    gpointer       $user_data
  ) {
    my gboolean $i = 0;

    dzl_suggestion_entry_default_position_func($!dse, $area, $i, $user_data);
    $is_absolute = $i.so;
    ($area, $is_absolute);
  }

  method get_activate_on_single_click is also<get-activate-on-single-click> {
    so dzl_suggestion_entry_get_activate_on_single_click($!dse);
  }

  method get_compact is also<get-compact> {
    so dzl_suggestion_entry_get_compact($!dse);
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      dzl_suggestion_entry_get_model($!dse),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_popover (:$raw = False ) is also<get-popover> {
    # cw: Return type says GTK::Widget, docs say Dazzle::Suggestion::Popover.
    #     We'll use the docs.
    propReturnObject(
      dzl_suggestion_entry_get_popover($!dse),
      $raw,
      |Dazzle::Suggestion::Popover.getTypePair
    );
  }

  method get_suggestion ( :$raw = False ) is also<get-suggestion> {
    propReturnObject(
      dzl_suggestion_entry_get_suggestion($!dse),
      $raw,
      |Dazzle::Suggestion.getTypePair
    );
  }

  method get_typed_text is also<get-typed-text> {
    dzl_suggestion_entry_get_typed_text($!dse);
  }

  method hide_suggestions is also<hide-suggestions> {
    dzl_suggestion_entry_hide_suggestions($!dse);
  }

  method set_activate_on_single_click (Int() $activate_on_single_click)
    is also<set-activate-on-single-click>
  {
    my gboolean $a = $activate_on_single_click.so.Int;

    dzl_suggestion_entry_set_activate_on_single_click($!dse, $a);
  }

  method set_compact (Int() $compact) is also<set-compact> {
    my gboolean $c = $compact.so.Int;

    dzl_suggestion_entry_set_compact($!dse, $c);
  }

  method set_model (GListModel() $model) is also<set-model> {
    dzl_suggestion_entry_set_model($!dse, $model);
  }

  method set_position_func (
             &func,
    gpointer $func_data         = gpointer,
             &func_data_destroy = Callable
  )
    is also<set-position-func>
  {
    dzl_suggestion_entry_set_position_func(
      $!dse,
      &func,
      $func_data,
      &func_data_destroy
    );
  }

  method set_suggestion (DzlSuggestion() $suggestion)
    is also<set-suggestion>
  {
    dzl_suggestion_entry_set_suggestion($!dse, $suggestion);
  }

  method window_position_func (
    GdkRectangle() $area,
    Int()          $is_absolute,
    gpointer       $user_data     = gpointer
  )
    is also<window-position-func>
  {
    my gboolean $i = $is_absolute.so.Int;

    dzl_suggestion_entry_window_position_func($!dse, $area, $i, $user_data);
  }

}

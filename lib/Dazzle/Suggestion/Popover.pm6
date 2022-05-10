use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Suggestion::Popover;

use GLib::Value;
use GTK::Widget;
use GTK::Window;

use GIO::Roles::ListModel;

our subset DzlSuggestionPopoverAncestry is export of Mu
  where DzlSuggestionPopover | GtkWindowAncestry;

class Dazzle::Suggestion::Popover is GTK::Window {
  has DzlSuggestionPopover $!dsp is implementor;

  submethod BUILD ( :$dzl-suggestion-popover ) {
    self.setDzlSuggestionPopover($dzl-suggestion-popover)
      if $dzl-suggestion-popover;
  }

  method setDzlSuggestionPopov80er (DzlSuggestionPopoverAncestry $_) {
    my $to-parent;

    $!dsp = do {
      when DzlSuggestionPopover {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestionPopover, $_);
      }
    }
    self.setGtkWindow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestionPopover
  { $!dsp }

  multi method new (
    DzlSuggestionPopoverAncestry  $dzl-suggestion-popover,
                                 :$ref                     = True
  ) {
    return Nil unless $dzl-suggestion-popover;

    my $o = self.bless( :$dzl-suggestion-popover );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-suggestion-popover = dzl_suggestion_popover_new();

    $dzl-suggestion-popover ?? self.bless( :$dzl-suggestion-popover ) !! Nil;
  }

  # Type: DzlSuggestion
  method model ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::ListModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::ListModel.getTypePair
        );
      },
      STORE => -> $, DzlSuggestion() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: GtkWidget
  method relative-to ( :$raw = False, :$widget = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GTK::Widget.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('relative-to', $gv);
        ReturnWidget(
          $gv.object,
          $raw,
          $widget,
        );
      },
      STORE => -> $, GtkWidget() $val is copy {
        $gv.object = $val;
        self.prop_set('relative-to', $gv);
      }
    );
  }

  # Type: DzlSuggestion
  method selected ( :$raw = False )  is rw  is g-property {
    my $gv = GLib::Value.new( Dazzle::Suggestion.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Suggestion.getTypePair
        );
      },
      STORE => -> $, DzlSuggestion() $val is copy {
        $gv.object = $val;
        self.prop_set('selected', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method subtitle-ellipsize is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(PangoEllipsizeMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle-ellipsize', $gv);
        PangoEllipsizeModeEnum( $gv.valueFromEnum(PangoEllipsizeMode) );
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('subtitle-ellipsize', $gv);
      }
    );
  }

  # Type: PangoEllipsizeMode
  method title-ellipsize is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(PangoEllipsizeMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title-ellipsize', $gv);
        PangoEllipsizeModeEnum( $gv.valueFromEnum(PangoEllipsizeMode) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(PangoEllipsizeMode) = $val;
        self.prop_set('title-ellipsize', $gv);
      }
    );
  }

  method suggestion-activated {
    self.connect($!dsp, 'suggestion-activated');
  }

  method activate_selected {
    dzl_suggestion_popover_activate_selected($!dsp);
  }

  method get_model ( :$raw = False ) {
    propReturnObject(
      dzl_suggestion_popover_get_model($!dsp),
      $raw,
      |GIO::ListModel.getTypePair
    )
  }

  method get_relative_to ( :$raw = False, :$widget = False ) {
    ReturnWidget(
      dzl_suggestion_popover_get_relative_to($!dsp),
      $raw,
      $widget
    );
  }

  method get_selected ( :$raw = False ) {
    propReturnObject(
      dzl_suggestion_popover_get_selected($!dsp),
      $raw,
      |Dazzle::Suggestion.getTypePair
    );
  }

  method move_by (Int() $amount) {
    my gint $a = $amount;

    dzl_suggestion_popover_move_by($!dsp, $a);
  }

  method popdown {
    dzl_suggestion_popover_popdown($!dsp);
  }

  method popup {
    dzl_suggestion_popover_popup($!dsp);
  }

  method set_model (GListModel() $model) {
    dzl_suggestion_popover_set_model($!dsp, $model);
  }

  method set_relative_to (GtkWidget() $widget) {
    dzl_suggestion_popover_set_relative_to($!dsp, $widget);
  }

  method set_selected (DzlSuggestion() $suggestion) {
    dzl_suggestion_popover_set_selected($!dsp, $suggestion);
  }

}

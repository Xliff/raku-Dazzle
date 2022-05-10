use v6.c;

use Method::Also;

use Cairo;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Suggestion;

use GLib::Roles::Object;
use GIO::Roles::Icon;


our subset DzlSuggestionAncestry is export of Mu
  where DzlSuggestion | GObject;

class Dazzle::Suggestion {
  also does GLib::Roles::Object;

  has DzlSuggestion $!ds is implementor;

  submethod BUILD ( :$dzl-suggestion ) {
    self.setDzlSuggestion($dzl-suggestion) if $dzl-suggestion;
  }

  method setDzlSuggestion (DzlSuggestionAncestry $_) {
    my $to-parent;

    $!ds = do {
      when DzlSuggestion {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSuggestion, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSuggestion
    is also<DzlSuggestion>
  { $!ds }

  multi method new (DzlSuggestionAncestry $dzl-suggestion, :$ref = True) {
    return Nil unless $dzl-suggestion;

    my $o = self.bless( :$dzl-suggestion );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-suggestion = dzl_suggestion_new();

    $dzl-suggestion ?? self.bless( :$dzl-suggestion ) !! Nil;
  }

  # Type: GIcon
  method icon ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GIO::Icona.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon', $gv);

        propReturnObject(
          $gv.object,
          $raw,
          |GIO::Icon.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'icon does not allow writing'
      }
    );
  }

  # Type: string
  method icon-name is rw  is g-property is also<icon_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: string
  method id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: GIcon
  method secondary-icon ( :$raw = False )
    is rw
    is g-property
    is also<secondary_icon>
  {
    my $gv = GLib::Value.new( GIO::Icon.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon', $gv);

        propReturnObject(
          $gv.object;
          $raw,
          |GIO::Icon.getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'secondary-icon does not allow writing'
      }
    );
  }

  # Type: string
  method secondary-icon-name
    is rw
    is g-property
    is also<secondary_icon_name>
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('secondary-icon-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('secondary-icon-name', $gv);
      }
    );
  }

  # Type: string
  method subtitle is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subtitle', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('subtitle', $gv);
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method replace-typed-text {
    self.connect-string($!ds, 'replace-typed-text');
  }

  method suggest-suffix {
    self.connect-string($!ds, 'suggest-suffix');
  }

  method get_icon ( :$raw = False ) is also<get-icon> {
    propReturnObject(
      dzl_suggestion_get_icon($!ds),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_icon_name is also<get-icon-name> {
    dzl_suggestion_get_icon_name($!ds);
  }

  method get_icon_surface (GtkWidget() $widget, :$raw = False)
    is also<get-icon-surface>
  {
    propReturnObject(
      dzl_suggestion_get_icon_surface($!ds, $widget);
      $raw,
      Cairo::cairo_surface_t,
      Cairo::Surface
    );
  }

  method get_id is also<get-id> {
    dzl_suggestion_get_id($!ds);
  }

  method get_secondary_icon ( :$raw = False ) is also<get-secondary-icon> {
    propReturnObject(
      dzl_suggestion_get_secondary_icon($!ds),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_secondary_icon_name is also<get-secondary-icon-name> {
    dzl_suggestion_get_secondary_icon_name($!ds);
  }

  method get_secondary_icon_surface (GtkWidget() $widget, :$raw = False)
    is also<get-secondary-icon-surface>
  {
    propReturnObject(
      dzl_suggestion_get_secondary_icon_surface($!ds, $widget),
      $raw,
      Cairo::cairo_surface_t,
      Cairo::Surface
    );
  }

  method get_subtitle is also<get-subtitle> {
    dzl_suggestion_get_subtitle($!ds);
  }

  method get_title is also<get-title> {
    dzl_suggestion_get_title($!ds);
  }

  method replace_typed_text (Str() $typed_text) {
    dzl_suggestion_replace_typed_text($!ds, $typed_text);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    dzl_suggestion_set_icon_name($!ds, $icon_name);
  }

  method set_id (Str() $id) is also<set-id> {
    dzl_suggestion_set_id($!ds, $id);
  }

  method set_secondary_icon_name (Str() $icon_name)
    is also<set-secondary-icon-name>
  {
    dzl_suggestion_set_secondary_icon_name($!ds, $icon_name);
  }

  method set_subtitle (Str() $subtitle) is also<set-subtitle> {
    dzl_suggestion_set_subtitle($!ds, $subtitle);
  }

  method set_title (Str() $title) is also<set-title> {
    dzl_suggestion_set_title($!ds, $title);
  }

  method suggest_suffix (Str() $typed_text) {
    dzl_suggestion_suggest_suffix($!ds, $typed_text);
  }

}

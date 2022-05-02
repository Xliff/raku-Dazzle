use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Preferences::Group;

use GTK::Bin;
use GTK::SizeGroup;

our subset DzlPreferencesGroupAncestry is export of Mu
  where DzlPreferencesGroup | GtkBinAncestry;

class Dazzle::Preferences::Group is GTK::Bin {
  has DzlPreferencesGroup $!dpg is implementor;

  submethod BUILD( :$dzl-preferences-group ) {
    self.setDzlPreferencesGroup($dzl-preferences-group)
      if $dzl-preferences-group;
  }

  method setDzlPreferencesGroup (DzlPreferencesGroupAncestry $_) {
    my $to-parent;

    $!dpg = do {
      when DzlBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesGroup, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesGroup
    is also<DzlPreferencesGroup>
  { $!dpg }

  multi method new (
    DzlPreferencesGroupAncestry  $dzl-preferences-group,
                                :$ref                    = True
  ) {
    return Nil unless $dzl-preferences-group;

    my $o = self.bless( :$dzl-preferences-group );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-preferences-group = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    $dzl-preferences-group ?? self.bless( :$dzl-preferences-group ) !! Nil;
  }

  # Type: boolean
  method is-list is rw  is g-property is also<is_list> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('is-list', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-list is a construct-only attribute'
      }
    );
  }

  # Type: GtkSelectionMode
  method mode is rw  is g-property {
    my $gv = GLib::Value.new( GLib::typeFromEnum(GtkSelectionMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mode', $gv);
        GtkSelectionModeEnum( $gv.valueFromEnum(GtkSelectionMode) )
      },

      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkSelectionMode) = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  # Type: int
  method priority is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('priority', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'priority is a construct-only attribute'
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
        warn 'title is a construct-only attribute'
      }
    );
  }

  method add (GtkWidget() $widget) {
    dzl_preferences_group_add($!dpg, $widget);
  }

  method get_priority is also<get-priority> {
    dzl_preferences_group_get_priority($!dpg);
  }

  method get_size_group (Int() $column, :$raw = False)
    is also<get-size-group>
  {
    my guint $c = $column;

    propReturnObject(
      dzl_preferences_group_get_size_group($!dpg, $c),
      $raw,
      |GTK::SizeGroup.getTypePair
    );
  }

  method get_title is also<get-title> {
    dzl_preferences_group_get_title($!dpg);
  }

  method get_type is static is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_preferences_group_get_type, $n, $t );
  }

  method refilter (DzlPatternSpec() $spec) {
    dzl_preferences_group_refilter($!dpg, $spec);
  }

  method set_map (GHashTable() $map) is also<set-map> {
    dzl_preferences_group_set_map($!dpg, $map);
  }

}

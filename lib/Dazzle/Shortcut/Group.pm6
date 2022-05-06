use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Box;

our subset DzlShortcutsGroupAncestry is export of Mu
  where DzlShortcutsGroup | GtkBoxAncestry;

class Dazzle::Shortcuts::Group is GTK::Box {
  has DzlShortcutsGroup $!dsg is implementor;

  submethod BUILD ( :$dzl-shortcuts-group ) {
    self.setDzlShortcutsGroup($dzl-shortcuts-group) if $dzl-shortcuts-group;
  }

  method setDzlShortcutsGroup(DzlShortcutsGroupAncestry $_) {
    my $to-parent;

    $!dsg = do {
      when DzlShortcutsGroup {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutsGroup, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutsGroup
  { $!dsg }

  multi method new (
    DzlShortcutsGroupAncestry  $dzl-shortcuts-group,
                              :$ref                  = True
  ) {
    return unless $dzl-shortcuts-group;

    my $o = self.bless( :$dzl-shortcuts-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-shortcuts-group = new_dzl_shortcuts_group(
      ::?CLASS.get_type,
      Str
    );

    $dzl-shortcuts-group ?? self.bless( :$dzl-shortcuts-group ) !! Nil;
  }

  # Type: DzlSizeGroup
  method accel-size-group is rw  is g-property {
    my $gv = GLib::Value.new( GTK::SizeGroup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'accel-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.object = $val;
        self.prop_set('accel-size-group', $gv);
      }
    );
  }

  # Type: uint
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height does not allow writing'
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

  # Type: DzlSizeGroup
  method title-size-group is rw  is g-property {
    my $gv = GLib::Value.new( GTK::SizeGroup.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'title-size-group does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GtkSizeGroup() $val is copy {
        $gv.object = $val;
        self.prop_set('title-size-group', $gv);
      }
    );
  }

  # Type: string
  method view is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('view', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('view', $gv);
      }
    );
  }

  method get_type is static {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_shortcuts_group_get_type, $n, $t );
  }

}

### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcuts-group.h

sub new_dzl_shortcuts_group (GType, Str)
  returns DzlShortcutsGroup
  is native(gobject)
  is symbol('g_object_new')
  is export
{ * }


sub dzl_shortcuts_group_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

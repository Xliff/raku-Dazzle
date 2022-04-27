use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GIO::MenuModel;
use GTK::Box;

our subset DzlMenuButtonSectionAncestry is export of Mu
  where DzlMenuButtonSection | GtkBoxAncestry;

class Dazzle::Menu::Button::Section is GTK::Box {
  has DzlMenuButtonSection $!dmbs;

  submethod BUILD ( :$dzl-menu-button-section ) {
    self.setDzlMenuButtonSection($dzl-menu-button-section)
      if $dzl-menu-button-section
  }

  method setDzlMenuButtonSection (DzlMenuButtonSectionAncestry $_) {
    my $to-parent;

    $!dmbs = do {
      when DzlMenuButtonSection {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlMenuButtonSection, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlMenuButtonSection
  { $!dmbs }

  multi method new (
    DzlMenuButtonSectionAncestry  $dzl-menu-button-section,
                                 :$ref                      = True
  ) {
    return Nil unless $dzl-menu-button-section;

    my $o = self.bless( :$dzl-menu-button-section );
    $o.ref if $ref;
    $o
  }
  multi method new (GMenuModel() $model, Str() $label) {
    my $dzl-menu-button-section = dzl_menu_button_section_new($!dmbs, $label);

    $dzl-menu-button-section ?? self.bless( :$dzl-menu-button-section ) !! Nil;
  }

  # Type: string
  method label is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'label does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: DzlMenuModel
  method model is rw  {
    my $gv = GLib::Value.new( GIO::MenuModel.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'model does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GMenuModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  # Type: boolean
  method show-accels is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-accels does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-accels', $gv);
      }
    );
  }

  # Type: boolean
  method show-icons is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-icons does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-icons', $gv);
      }
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/menus/dzl-menu-button-section.h

sub dzl_menu_button_section_new (GMenuModel $model, Str $label)
  returns DzlMenuButtonSection
  is native(dazzle)
  is export
{ * }

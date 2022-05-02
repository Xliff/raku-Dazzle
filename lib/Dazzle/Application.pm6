use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Application;

use GIO::Menu;
use GTK::Application;
use Dazzle::ApplicationWindow;
#use Dazzle::Manager::Menu;
# use Dazzle::Manager::Theme;
# use Dazzle::Manager::Shortcut;

our subset DzlApplicationAncestry is export of Mu
  where DzlApplication | GtkApplicationAncestry;

class Dazzle::Application is GTK::Application {
  has DzlApplication $!da is implementor;

  submethod BUILD (
    :$dzl-application,
    :$window-type,
    :$width                       = 640,
    :$height                      = 480,
    :$window            is copy;
  ) {
    self.setDzlApplication($dzl-application) if $dzl-application;

    ::?CLASS.init;
  }

  method setDzlApplication (DzlApplicationAncestry $_) {
    my $to-parent;

    $!da = do {
      when DzlApplication {
        $to-parent = cast(GtkApplication, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlApplication, $_);
      }
    }
    self.setGtkApplication($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlApplication
  { $!da }

  multi method new (DzlApplicationAncestry $dzl-application, :$ref = True) {
    return Nil unless $dzl-application;

    my $o = self.bless( :$dzl-application );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str()  $application_id,
    Int()  $flags                     = 0,
    Int() :$width                     = 640,
    Int() :$height                    = 480,
          :$window,
          :$window-type
  ) {
    my GApplicationFlags $f = $flags;

    my $dzl-application = dzl_application_new($application_id, $f);

    $dzl-application
      ?? self.bless(
           application-window-class => Dazzle::ApplicationWindow,

           :$dzl-application,
           :$width,
           :$height,
           :$window,
           :$window-type
         )
      !! Nil;
  }

  # Type: DzlMenuManager
  # method menu-manager ( :$raw = False ) is rw  {
  #   my $gv = GLib::Value.new( Dazzle::Manager::Menu.get_type );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('menu-manager', $gv)
  #       );
  #       propReturnObject(
  #         $gv.object,
  #         $raw,
  #         |Dazzle::Manager::Menu.getTypePair
  #       );
  #     },
  #     STORE => -> $,  $val is copy {
  #       warn 'menu-manager does not allow writing'
  #     }
  #   );
  # }

  # Type: DzlShortcutManager
  # method shortcut-manager ( :$raw = False ) is rw  {
  #   my $gv = GLib::Value.new( Dazzle::Manager::Shortcut.get_type );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('shortcut-manager', $gv)
  #       );
  #       propReturnObject(
  #         $gv.object,
  #         $raw,
  #         |Dazzle::Manager::Shortcut.getTypePair
  #       );
  #     },
  #     STORE => -> $, $val is copy {
  #       warn 'shortcut-manager does not allow writing'
  #     }
  #   );
  # }

  # Type: DzlThemeManager
  # method theme-manager ( :$raw = False ) is rw  {
  #   my $gv = GLib::Value.new( Dazzle::Manager::Theme.get_type );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
  #         self.prop_get('theme-manager', $gv)
  #       );
  #       propReturnObject(
  #         $gv.object,
  #         $raw,
  #         |Dazzle::Manager::Theme.getTypePair
  #       );
  #     },
  #     STORE => -> $, $val is copy {
  #       warn 'theme-manager does not allow writing'
  #     }
  #   );
  # }

  method add_resources (Str() $resource_path) {
    dzl_application_add_resources($!da, $resource_path);
  }

  method get_menu_by_id (Str() $menu_id, :$raw = False) {
    propReturnObject(
      dzl_application_get_menu_by_id($!da, $menu_id),
      $raw,
      |GIO::Menu.getTypePair
    );
  }

  method get_menu_manager ( :$raw = False ) {
    propReturnObject(
      dzl_application_get_menu_manager($!da),
      $raw,
      |Dazzle::Manager::Menu.getTypePair
    );
  }

  method get_shortcut_manager ( :$raw = False ) {
    propReturnObject(
      dzl_application_get_shortcut_manager($!da),
      $raw,
      |Dazzle::Manager::Shortcut.getTypePair
    )
  }

  method get_theme_manager ( :$raw = False ) {
    propReturnObject(
      dzl_application_get_theme_manager($!da),
      $raw,
      |Dazzle::Manager::Theme.getTypePair
    );
  }

  method remove_resources (Str() $resource_path) {
    dzl_application_remove_resources($!da, $resource_path);
  }

}

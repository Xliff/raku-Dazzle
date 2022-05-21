use v6.c;

use Method::Also;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::Object;

our subset DzlThemeManagerAncestry is export of Mu
  when DzlThemeManager | GObject;

class Dazzle::Theme::Manager {
  also does GLib::Roles::Object;

  has DzlThemeManager $!dtm is implementor;

  submethod BUILD (:$dzl-theme-managere) {
    self.setDzlThemeManager($dzl-theme-managere) if $dzl-theme-managere;
  }

  method setDzlThemeManager (DzlThemeManagerAncestry $_) {
    my $to-parent;

    $!dtm = do {
      when DzlThemeManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlThemeManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlThemeManager
    is also<DzlThemeManager>
  { $!dtm }

  multi method new (DzlThemeManagerAncestry $dzl-theme-managere, :$ref = True) {
    return Nil unless $dzl-theme-managere;

    my $o = self.bless( :$dzl-theme-managere );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-theme-manager = dzl_theme_manager_new();

    $dzl-theme-manager ?? self.bless( :$dzl-theme-manager ) !! Nil;
  }

  method add_resources (Str() $resource_path) is also<add-resources> {
    dzl_theme_manager_add_resources($!dtm, $resource_path);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_theme_manager_get_type, $n, $t );
  }

  method remove_resources (Str() $resource_path) is also<remove-resources> {
    dzl_theme_manager_remove_resources($!dtm, $resource_path);
  }

}


### /usr/src/libdazzle-3.42.0/src/theming/dzl-theme-manager.h

sub dzl_theme_manager_add_resources (DzlThemeManager $self, Str $resource_path)
  is native(dazzle)
  is export
{ * }

sub dzl_theme_manager_new ()
  returns DzlThemeManager
  is native(dazzle)
  is export
{ * }

sub dzl_theme_manager_remove_resources (
  DzlThemeManager $self,
  Str             $resource_path
)
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_theme_manager_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

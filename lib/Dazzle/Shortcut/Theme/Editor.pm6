use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::Bin;
use Dazzle::Shortcut::Theme;

use GLib::Roles::Signals::Generic;

our subset DzlShortcutThemeEditorAncestry is export of Mu
  where DzlShortcutThemeEditor | GtkBinAncestry;

class Dazzle::Shortcut::Theme::Editor is GTK::Bin {
  also does GLib::Roles::Signals::Generic;

  has DzlShortcutThemeEditor $!dste is implementor;

  submethod BUILD ( :$dzl-shortcut-theme-editor ) {
    self.setDzlShortcutThemeEditor($dzl-shortcut-theme-editor)
      if $dzl-shortcut-theme-editor;
  }

  method setDzlShortcutThemeEditor (DzlShortcutThemeEditorAncestry $_) {
    my $to-parent;

    $!dste = do {
      when DzlShortcutThemeEditor  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutThemeEditor, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutThemeEditor
    is also<DzlShortcutThemeEditor>
  { $!dste }

  multi method new (
    DzlShortcutThemeEditorAncestry  $dzl-shortcut-theme-editor,
                                   :$ref                        = True
  ) {
    return Nil unless $dzl-shortcut-theme-editor;

    my $o = self.bless( :$dzl-shortcut-theme-editor );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-shortcut-theme-editor = dzl_shortcut_theme_editor_new();

    $dzl-shortcut-theme-editor ?? self.bless( :$dzl-shortcut-theme-editor )
                               !! Nil;
  }

  method theme ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( DzlShortcutTheme );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('theme', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::Shortcut::Theme.getTypePair
        );
      },
      STORE => -> $, DzlShortcutTheme() $val is copy {
        $gv.object = $val;
        self.prop_set('theme', $gv);
      }
    );
  }

  method changed {
    self.connect($!dste, 'changed');
  }

  method get_theme ( :$raw = False ) is also<get-theme> {
    propReturnObject(
      dzl_shortcut_theme_editor_get_theme($!dste),
      $raw,
      |Dazzle::Shortcut::Theme.getTypePair
    );
  }

  method set_theme (DzlShortcutTheme() $theme) is also<set-theme> {
    dzl_shortcut_theme_editor_set_theme($!dste, $theme);
  }

}


### /usr/src/libdazzle-3.42.0/src/shortcuts/dzl-shortcut-theme-editor.h

sub dzl_shortcut_theme_editor_get_theme (DzlShortcutThemeEditor $self)
  returns DzlShortcutTheme
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_editor_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_shortcut_theme_editor_set_theme (
  DzlShortcutThemeEditor $self,
  DzlShortcutTheme       $theme
)
  is native(dazzle)
  is export
{ * }

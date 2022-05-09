use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Shortcut::Model;

use GTK::TreeStore;
use Dazzle::Shortcut::Manager;
use Dazzle::Shortcut::Theme;

our subset DzlShortcutModelAncestry is export of Mu
  where DzlShortcutModel | GtkTreeStoreAncestry;

class Dazzle::Shortcut::Model is GTK::TreeStore {
  has DzlShortcutModel $!dsm is implementor;

  submethod BUILD ( :$dzl-shortcut-model ) {
    self.setDzlShortcutModel($dzl-shortcut-model) if $dzl-shortcut-model;
  }

  method setDzlShortcutModel(DzlShortcutModelAncestry $_) {
    my $to-parent;

    $!dsm = do {
      when DzlShortcutModel {
        $to-parent = cast(GtkTreeStore, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlShortcutModel, $_);
      }
    }
    self.setGtkTreeStore($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlShortcutModel
  { $!dsm }

  multi method new (
    DzlShortcutModelAncestry  $dzl-shortcut-model,
                              :$ref                  = True
  ) {
    return unless $dzl-shortcut-model;

    my $o = self.bless( :$dzl-shortcut-model );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-shortcut-model = dzl_shortcut_model_new();

    $dzl-shortcut-model ?? self.bless( :$dzl-shortcut-model ) !! Nil;
  }

  # Type: DzlShortcutManager
  method manager ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Dazzle::ShortcutManager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('manager', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |Dazzle::ShortcutManager.getTypePair
        );
      },
      STORE => -> $, DzlShortcutManager() $val is copy {
        $gv.object = $val;
        self.prop_set('manager', $gv);
      }
    );
  }

  # Type: DzlShortcutTheme
  method theme ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( Dazzled::Shortcut::Theme.get_type );
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

  method get_manager ( :$raw = False ) {
    propReturnObject(
      dzl_shortcut_model_get_manager($!dsm),
      $raw,
      |Dazzle::Shortcut::Manager.getTypePair
    );
  }

  method get_theme ( :$raw = False ) {
    propReturnObject(
      dzl_shortcut_model_get_theme($!dsm),
      $raw,
      |Dazzle::Shortcut::Theme.getTypePair
    );
  }

  method rebuild {
    dzl_shortcut_model_rebuild($!dsm);
  }

  method set_chord (GtkTreeIter() $iter, DzlShortcutChord() $chord) {
    dzl_shortcut_model_set_chord($!dsm, $iter, $chord);
  }

  method set_manager (DzlShortcutManager() $manager) {
    dzl_shortcut_model_set_manager($!dsm, $manager);
  }

  method set_theme (DzlShortcutTheme() $theme) {
    dzl_shortcut_model_set_theme($!dsm, $theme);
  }

}

use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Menu::Joined;

use GIO::MenuModel;

our subset DzlJoinedMenuAncestry is export of Mu
  where DzlJoinedMenu | GMenuModelAncestry;

class Dazzle::Menu::Joined is GIO::MenuModel {
  has DzlJoinedMenu $!djm;

  submethod BUILD ( :$dzl-joined-menu ) {
    self.setDzlJoinedMenu($dzl-joined-menu) if $dzl-joined-menu
  }

  method setDzlJoinedMenu (DzlJoinedMenuAncestry $_) {
    my $to-parent;

    $!djm = do {
      when DzlJoinedMenu {
        $to-parent = cast(GMenuModel, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlJoinedMenu, $_);
      }
    }
    self.setGMenuModel($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlJoinedMenu
  { $!djm }

  multi method new (DzlJoinedMenuAncestry  $dzl-joined-menu, :$ref = True) {
    return Nil unless $dzl-joined-menu;

    my $o = self.bless( :$dzl-joined-menu );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-joined-menu = dzl_joined_menu_new();

    $dzl-joined-menu ?? self.bless( :$dzl-joined-menu ) !! Nil;
  }

  method append_menu (GMenuModel() $model) {
    dzl_joined_menu_append_menu($!djm, $model);
  }

  method get_n_joined {
    dzl_joined_menu_get_n_joined($!djm);
  }

  method prepend_menu (GMenuModel() $model) {
    dzl_joined_menu_prepend_menu($!djm, $model);
  }

  method remove_index (Int() $index) {
    my guint $i = $index;

    dzl_joined_menu_remove_index($!djm, $i);
  }

  method remove_menu (GMenuModel $model) {
    dzl_joined_menu_remove_menu($!djm, $model);
  }

}

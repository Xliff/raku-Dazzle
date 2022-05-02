use v6.c;

use Method::Also;
use NativeCall;

use Dazzle::Raw::Types;

use GTK::Box;

use Dazzle::Roles::Signals::Path::Bar;

our subset DzlPathBarAncestry is export of Mu
  where DzlPathBar | GtkBoxAncestry;

class Dazzle::Path::Bar is GTK::Box {
  also does Dazzle::Roles::Signals::Path::Bar;

  has DzlPathBar $!dpb is implementor;

  submethod BUILD ( :$dzl-path-bar ) {
    self.setDzlPathBar($dzl-path-bar) if $dzl-path-bar;
  }

  method setDzlPathBar(DzlPathBarAncestry $_) {
    my $to-parent;

    $!dpb = do {
      when DzlPathBar {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPathBar, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPathBar
  { $!dpb }

  multi method new (DzlPathBarAncestry $dzl-path-bar, :$ref = True) {
    return unless $dzl-path-bar;

    my $o = self.bless( :$dzl-path-bar );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-path-bar = dzl_path_bar_new();

    $dzl-path-bar ?? self.bless( :$dzl-path-bar ) !! Nil;
  }

  method element-selected is also<element_selected> {
    self.connect-element-selected($!dpb);
  }

  method populate-menu is also<populate_menu> {
    self.connect-populate-menu($!dpb);
  }

  method get_path ( :$raw = False ) is also<get-path> {
    propReturnObject(
      dzl_path_bar_get_path($!dpb),
      $raw,
      |Dazzle::Path.getTypePair
    );
  }

  method set_path (DzlPath() $path) is also<set-path> {
    dzl_path_bar_set_path($!dpb, $path);
  }

  method set_selected_index (Int() $index) is also<set-selected-index> {
    my guint $i = $index;

    dzl_path_bar_set_selected_index($!dpb, $i);
  }
}

### /usr/src/libdazzle-3.42.0/src/pathbar/dzl-path-bar.h

sub dzl_path_bar_get_path (DzlPathBar $self)
  returns DzlPath
  is native(dazzle)
  is export
{ * }

sub dzl_path_bar_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_path_bar_set_path (DzlPathBar $self, DzlPath $path)
  is native(dazzle)
  is export
{ * }

sub dzl_path_bar_set_selected_index (DzlPathBar $self, guint $index)
  is native(dazzle)
  is export
{ * }

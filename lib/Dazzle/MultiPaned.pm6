use v6.c;

use Method::Also;
use NativeCall;

use Dazzle::Raw::Types;

use GTK::Container;
use GTK::Widget;

use GTK::Roles::Orientable;
use GTK::Roles::Signals::Generic;

our subset DzlMultiPanedAncestry is export of Mu
  where DzlMultiPaned | GtkOrientable | GtkContainerAncestry;

class Dazzle::MultiPaned is GTK::Container {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::Generic;

  has DzlMultiPaned $!dmp is implementor;

  submethod BUILD ( :$dzl-multi-paned ) {
    self.setDzlMultiPaned($dzl-multi-paned) if $dzl-multi-paned;
  }

  method setDzlMultiPaned (DzlMultiPanedAncestry $_) {
    my $to-parent;

    $!dmp = do {
      when DzlMultiPaned {
        $to-parent = cast(GtkContainer, $_);
        $_;
      }

      when GtkOrientable {
        $to-parent = cast(GtkContainer, $_);
        $!or       = $_;
        cast(DzlMultiPaned, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlMultiPaned, $_);
      }
    }
    self.setGtkContainer($to-parent);
    self.roleInit-GtkOrientable;
  }

  method Dazzle::Raw::Definitions::DzlMultiPaned
  { $!dmp }

  multi method new (DzlMultiPanedAncestry $dzl-multi-paned, :$ref = True) {
    return Nil unless $dzl-multi-paned;

    my $o = self.bless( :$dzl-multi-paned );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-multi-paned = dzl_multi_paned_new();

    $dzl-multi-paned ?? self.bless( :$dzl-multi-paned ) !! Nil;
  }

  method resize-drag-begin {
    self.connect-widget($!dmp, 'resize-drag-begin');
  }

  method resize-drag-end {
    self.connect-widget($!dmp, 'resize-drag-end');
  }

  method get_at_point (Int() $x, Int() $y, :$raw = False, :$widget = False)
    is also<get-at-point>
  {
    my gint ($xx, $yy) = ($x, $y);

    ReturnWidget(
      dzl_multi_paned_get_at_point($!dmp, $xx, $yy),
      $raw,
      $widget
    );
  }

  method get_n_children is also<get-n-children> {
    dzl_multi_paned_get_n_children($!dmp);
  }
  # cw: Must be considered an override, so do not use the MOP.
  method elems {
    self.get_n_children
  }

  method get_nth_child (Int() $nth, :$raw = False, :$widget = False)
    is also<get-nth-child>
  {
    my guint $n = $nth;

    ReturnWidget(
      dzl_multi_paned_get_nth_child($!dmp, $nth),
      $raw,
      $widget
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-multi-paned.h

sub dzl_multi_paned_get_at_point (DzlMultiPaned $self, gint $x, gint $y)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_multi_paned_get_n_children (DzlMultiPaned $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_multi_paned_get_nth_child (DzlMultiPaned $self, guint $nth)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_multi_paned_new ()
  returns DzlMultiPaned
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_multi_paned_get_type
  returns GType
  is native(dazzle)
  is export
{ * }

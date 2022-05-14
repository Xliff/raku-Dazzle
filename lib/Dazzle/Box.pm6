use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Box;

our subset DzlBoxAncestry is export of Mu
  where DzlBox | GtkBoxAncestry;

class Dazzle::Box is GTK::Box {
  has DzlBox $!db is implementor;

  submethod BUILD ( :$dzl-box ) {
    self.setDzlBox($dzl-box) if $dzl-box;
  }

  method setDzlBox(DzlBoxAncestry $_) {
    my $to-parent;

    $!db = do {
      when DzlBox {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlBox, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlBox
  { $!db }

  multi method new (DzlBoxAncestry $dzl-box, :$ref = True) {
    return unless $dzl-box;

    my $o = self.bless( :$dzl-box );
    $o.ref if $ref;
    $o;
  }
  method new {
    my $dzl-box = dzl_box_new();

    $dzl-box ?? self.bless( :$dzl-box ) !! Nil;
  }

  method get_max_width_request {
    dzl_box_get_max_width_request($!db);
  }

  method get_nth_child (Int() $nth, :$raw = False, :$widget = False) {
    my guint $n = $nth;

    ReturnWidget(
      dzl_box_get_nth_child($!db, $n),
      $raw,
      $widget,
    );
  }

  method set_max_width_request (Int() $max_width_request) {
    my gint $m = $max_width_request;

    dzl_box_set_max_width_request($!db, $m);
  }

  method AT-POS (\k) {
    self.get_nth_child(k);
  }

}


### /usr/src/libdazzle-3.42.0/src/widgets/dzl-box.h

sub dzl_box_get_max_width_request (DzlBox $self)
  returns gint
  is native(dazzle)
  is export
{ * }

sub dzl_box_get_nth_child (DzlBox $self, guint $nth)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_box_new ()
  returns DzlBox
  is native(dazzle)
  is export
{ * }

sub dzl_box_set_max_width_request (DzlBox $self, gint $max_width_request)
  is native(dazzle)
  is export
{ * }

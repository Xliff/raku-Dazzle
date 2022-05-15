use v6.c;

use NativeCall;
use Method::Also;

use Dazzle::Raw::Types;

use GTK::Box;

our subset DzlPriorityBoxAncestry is export of Mu
  where DzlPriorityBox | GtkBoxAncestry;

class Dazzle::PriorityBox is GTK::Box {
  has DzlPriorityBox $!dpb is implementor;

  submethod BUILD ( :$dzl-priority-box ) {
    self.setDzlPriorityBox($dzl-priority-box) if $dzl-priority-box;
  }

  method setDzlPriorityBox(DzlPriorityBoxAncestry $_) {
    my $to-parent;

    $!dpb = do {
      when DzlPriorityBox {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPriorityBox, $_);
      }
    }
    self.setGtkBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPriorityBox
    is also<DzlPriorityBox>
  { $!dpb }

  multi method new (DzlPriorityBoxAncestry $dzl-priority-box, :$ref = True) {
    return unless $dzl-priority-box;

    my $o = self.bless( :$dzl-priority-box );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-priority-box = dzl_priority_box_new();

    $dzl-priority-box ?? self.bless( :$dzl-priority-box ) !! Nil;
  }

}


### /usr/src/libdazzle-3.42.0/src/widgets/dzl-priority-box.h

sub dzl_priority_box_new ()
  returns DzlPriorityBox
  is native(dazzle)
  is export
{ * }

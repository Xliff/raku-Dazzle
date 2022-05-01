use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::TransientGrab;

use GLib::Roles::Object;

our subset DzlDockTransientGrabAncestry is export of Mu
  where DzlDockTransientGrab | GObject;

class Dazzle::Dock::TransientGrab {
  also does GLib::Roles::Object;

  has DzlDockTransientGrab $!ddtg is implementor;

  submethod BUILD ( :$dzl-dock-transient-grab ) {
    self.setDzlDockTransientGrab($dzl-dock-transient-grab)
      if $dzl-dock-transient-grab;
  }

  method setDzlDockTransientGrab (DzlDockTransientGrabAncestry $_) {
    my $to-parent;

    $!ddtg = do {
      when DzlDockTransientGrab {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockTransientGrab, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlDockTransientGrab
  { $!ddtg }

  multi method new (
    DzlDockTransientGrabAncestry  $dzl-dock-transient-grab,
                                 :$ref                      = True
  ) {
    return Nil unless $dzl-dock-transient-grab;

    my $o = self.bless( :$dzl-dock-transient-grab );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-transient-grab = dzl_dock_transient_grab_new();

    $dzl-dock-transient-grab ?? self.bless( :$dzl-dock-transient-grab )
                             !! Nil;
  }

  # Type: uint
  method timeout is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'timeout does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('timeout', $gv);
      }
    );
  }

  method acquire {
    dzl_dock_transient_grab_acquire($!ddtg);
  }

  method add_item (DzlDockItem() $item) {
    dzl_dock_transient_grab_add_item($!ddtg, $item);
  }

  method cancel {
    dzl_dock_transient_grab_cancel($!ddtg);
  }

  method contains (DzlDockItem() $item) {
    so dzl_dock_transient_grab_contains($!ddtg, $item);
  }

  method get_timeout {
    dzl_dock_transient_grab_get_timeout($!ddtg);
  }

  method is_descendant (GtkWidget() $widget) {
    so dzl_dock_transient_grab_is_descendant(
      $!ddtg,
      $widget
    );
  }

  method release {
    dzl_dock_transient_grab_release($!ddtg);
  }

  method remove_item (DzlDockItem() $item) {
    dzl_dock_transient_grab_remove_item($!ddtg, $item);
  }

  method set_timeout (Int() $timeout) {
    my guint $t = $timeout;

    dzl_dock_transient_grab_set_timeout($!ddtg, $t);
  }

  method steal_common_ancestors (DzlDockTransientGrab() $other) {
    dzl_dock_transient_grab_steal_common_ancestors($!ddtg, $other);
  }

}

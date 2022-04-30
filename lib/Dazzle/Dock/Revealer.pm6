use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::Revealer;

use Dazzle::Bin;

our subset DzlDockRevealerAncestry is export of Mu
  where DzlDockRevealer | DzlBinAncestry;

class Dazzle::Dock::Revealer is Dazzle::Bin {
  has DzlDockRevealer $!ddr is implementor;

  submethod BUILD ( :$dzl-dock-revealer ) {
    self.setDzlDockRevealer($dzl-dock-revealer) if $dzl-dock-revealer;
  }

  method setDzlDockRevealer (DzlDockRevealerAncestry $_) {
    my $to-parent;

    $!ddr = do {
      when DzlDockRevealer {
        $to-parent = cast(DzlBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockRevealer, $_);
      }
    }
    self.setDzlBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlDockRevealer
  { $!ddr }

  multi method new (DzlDockRevealerAncestry  $dzl-dock-revealer, :$ref = True) {
    return Nil unless $dzl-dock-revealer;

    my $o = self.bless( :$dzl-dock-revealer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-revealer = dzl_dock_revealer_new();

    $dzl-dock-revealer ?? self.bless( :$dzl-dock-revealer ) !! Nil;
  }

  # Type: boolean
  method child-revealed is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('child-revealed', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'child-revealed does not allow writing'
      }
    );
  }

  # Type: int
  method position is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'position does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('position', $gv);
      }
    );
  }

  # Type: boolean
  method position-set is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'position-set does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('position-set', $gv);
      }
    );
  }

  # Type: boolean
  method reveal-child is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'reveal-child does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('reveal-child', $gv);
      }
    );
  }

  # Type: uint
  method transition-duration is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'transition-duration does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('transition-duration', $gv);
      }
    );
  }

  # Type: DzlDockRevealerTransitionType
  method transition-type is rw  {
    my $gv = GLib::Value.new( self.transition_type_get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'transition-type does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(DzlDockRevealerTransitionType) = $val;
        self.prop_set('transition-type', $gv);
      }
    );
  }

  method animate_to_position (Int() $position, Int() $transition_duration) {
    my gint  $p = $position;
    my guint $t = $transition_duration;

    dzl_dock_revealer_animate_to_position($!ddr, $p, $t);
  }

  method get_child_revealed {
    dzl_dock_revealer_get_child_revealed($!ddr);
  }

  method get_position {
    dzl_dock_revealer_get_position($!ddr);
  }

  method get_position_set {
    dzl_dock_revealer_get_position_set($!ddr);
  }

  method get_reveal_child {
    dzl_dock_revealer_get_reveal_child($!ddr);
  }

  method get_transition_duration {
    dzl_dock_revealer_get_transition_duration($!ddr);
  }

  method get_transition_type {
    DzlDockRevealerTransitionTypeEnum(
      dzl_dock_revealer_get_transition_type($!ddr)
    );
  }

  method is_animating {
    so dzl_dock_revealer_is_animating($!ddr);
  }

  method set_position (Int() $position) {
    my gint $p = $position;

    dzl_dock_revealer_set_position($!ddr, $p);
  }

  method set_position_set (Int() $position_set) {
    my gboolean $p = $position_set;

    dzl_dock_revealer_set_position_set($!ddr, $p);
  }

  method set_reveal_child (Int() $reveal_child) {
    my gboolean $r = $reveal_child.so.Int;

    dzl_dock_revealer_set_reveal_child($!ddr, $reveal_child);
  }

  method set_transition_duration (Int() $transition_duration) {
    my guint $t = $transition_duration;

    dzl_dock_revealer_set_transition_duration($!ddr, $t);
  }

  method set_transition_type (Int() $transition_type) {
    my DzlDockRevealerTransitionType $t = $transition_type;

    dzl_dock_revealer_set_transition_type($!ddr, $t);
  }

  method transition_type_get_type {
    dzl_dock_revealer_transition_type_get_type();
  }

}

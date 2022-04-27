use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::Animation;

use GLib::Roles::Object;
use GLib::Roles::Signals::Generic;

our subset DzlAnimationAncestry is export of Mu
  where DzlAnimation | GObject;

class Dazzle::Animation {
  also does GLib::Roles::Object;
  also does GLib::Roles::Signals::Generic;

  has DzlAnimation $!da;

  submethod BUILD ( :$dzl-animation ) {
    self.setDzlAnimation($dzl-animation) if $dzl-animation;
  }

  method setDzlAnimation (DzlAnimationAncestry $_) {
    my $to-parent;

    $!da = do {
      when DzlAnimation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlAnimation, $_)
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlAnimation
  { $!da }

  multi method new (DzlAnimationAncestry $dzl-animation, :$ref = True) {
    return Nil unless $dzl-animation;

    my $o = self.bless( :$dzl-animation );
    $o.ref if $ref;
    $o;
  }

  # Type: uint
  method duration is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        warn 'duration does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('duration', $gv);
      }
    );
  }

  # Type: GdkFrameClock
  method frame-clock is rw  {
    my $gv = GLib::Value.new( GDK::FrameClock.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'frame-clock does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GdkFrameClock() $val is copy {
        $gv.object = $val;
        self.prop_set('frame-clock', $gv);
      }
    );
  }

  # Type: DzlAnimationMode
  method mode is rw  {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(DzlAnimationMode) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'mode does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(DzlAnimationMode) = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  # Type: GObject
  method target is rw  {
    my $gv = GLib::Value.new( GLib::Object.get_typer );
    Proxy.new(
      FETCH => sub ($) {
        warn 'target does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, GObject() $val is copy {
        $gv.object = $val;
        self.prop_set('target', $gv);
      }
    );
  }

  method tick {
    self.connect($!da, 'tick');
  }

  proto method add_property (|)
  { * }

  multi method add_property (GParamSpec() $pspec) {
    my $v = GLib::Value.new($pspec.value-type);

    $v.value = isGTypeAnInteger($pspec.value-type) ?? 0 !! 0e0;

    samewith($pspec, $v);
  }
  multi method add_property (GParamSpec() $pspec, GValue() $value) {
    dzl_animation_add_property($!da, $pspec, $value);
  }

  method calculate_duration (
    GdkFrameClock() $fc,
    Num()           $from_value,
    Num()           $to_value
  )
    is static
  {
    my gdouble ($f, $t) = ($from_value, $to_value);

    dzl_animation_calculate_duration($fc, $f, $t);
  }

  method animate (
    GObject()       $object,
    Int()           $mode,
    Int()           $duration_msec,
    GdkFrameClock() $frame_clock,
                    *@properties
  ) {
    my DzlAnimationMode $m = $mode;
    my guint            $d = $duration_msec;

    my $dzl-animation = dzl_object_animate($object, $m, $d, $frame_clock, Str);

    $dzl-animation = $dzl-animation ?? self.bless( :$dzl-animation ) !! Nil;

    return Nil            unless $dzl-animation;
    return $dzl-animation unless @properties;

    my %properties = self.getProperties;

    for @properties.rotor(2) -> ($prop, $val) {
      my $pspec = %properties{$prop};

      unless $pspec {
        warn "Could not find property '{ $prop }' to animate!'";
        next;
      }

      my $v = GLib::Value.new($pspec.value_type);
      $v.value = $val;
      $dzl-animation.add_property($prop, $v);
    }

    $dzl-animation
  }

  method mode_get_type {
    DzlAnimationModeEnum( dzl_animation_mode_get_type() )
  }

  method start {
    dzl_animation_start($!da);
  }

  method stop {
    dzl_animation_stop($!da);
  }

}

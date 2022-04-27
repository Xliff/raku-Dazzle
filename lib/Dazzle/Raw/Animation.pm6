use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Object;
use GDK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Animation;

### /usr/src/libdazzle-3.42.0/src/animation/dzl-animation.h

sub dzl_animation_add_property (
  DzlAnimation $animation,
  GParamSpec   $pspec,
  GValue       $value
)
  is native(dazzle)
  is export
{ * }

sub dzl_animation_calculate_duration (
  GdkMonitor $monitor,
  gdouble    $from_value,
  gdouble    $to_value
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_object_animate (
  GObject          $object,
  DzlAnimationMode $mode,
  guint            $duration_msec,
  GdkFrameClock    $frame_clock,
  Str
)
  returns DzlAnimation
  is native(dazzle)
  is export
{ * }

#
# sub dzl_object_animate_full (
#   gpointer $object,
#   DzlAnimationMode $mode,
#   guint $duration_msec,
#   GdkFrameClock $frame_clock,
#   GDestroyNotify $notify,
#   gpointer $notify_data,
#   Str $first_property
#   ...
# )
#   returns DzlAnimation
#   is native(dazzle)
#   is export
# { * }

# cw: va_list is out of scope
# cw: The varadic part is: property-name, starting value!
# sub dzl_object_animatev (
#   gpointer $object,
#   DzlAnimationMode $mode,
#   guint $duration_msec,
#   GdkFrameClock $frame_clock,
#   Str $first_property,
#   va_list $args
# )
#   returns DzlAnimation
#   is native(dazzle)
#   is export
# { * }

# cw: The varadic part is: property-name, starting value!
# sub dzl_object_animatev (
#   gpointer $object,
#   DzlAnimationMode $mode,
#   guint $duration_msec,
#   GdkFrameClock $frame_clock,
#   Str $first_property,
#   va_list $args
# )
#   returns DzlAnimation
#   is native(dazzle)
#   is export
# { *

sub dzl_animation_mode_get_type ()
  returns GType
  is native(dazzle)
  is export
{ * }

sub dzl_animation_start (DzlAnimation $animation)
  is native(dazzle)
  is export
{ * }

sub dzl_animation_stop (DzlAnimation $animation)
  is native(dazzle)
  is export
{ * }

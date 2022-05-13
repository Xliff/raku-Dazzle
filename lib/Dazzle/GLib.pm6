use v6.c;

use MONKEY-TYPING;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::DateTime;

augment class GLib::DateTime {

  method time_format_for_display is also<Str> {
    dzl_g_date_time_format_for_display(self.GDateTime);
  }

  method time_span_to_label (GTimeSpan() $span) is static {
    dzl_g_time_span_to_label($span);
  }

}


### /usr/src/libdazzle-3.42.0/src/util/dzl-date-time.h

sub dzl_g_date_time_format_for_display (GDateTime $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_g_time_span_to_label (GTimeSpan $span)
  returns Str
  is native(dazzle)
  is export
{ * }

# cw: Will be NYI until an apropriate class can be found.
sub dzl_g_time_span_to_label_mapping (
  GBinding $binding,
  GValue   $from_value,
  GValue   $to_value,
  gpointer $user_data
)
  returns uint32
  is native(dazzle)
  is export
{ * }

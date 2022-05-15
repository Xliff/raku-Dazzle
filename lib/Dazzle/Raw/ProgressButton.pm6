use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::ProgressButton;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-progress-button.h

sub dzl_progress_button_get_progress (DzlProgressButton $self)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_progress_button_get_show_progress (DzlProgressButton $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_progress_button_new ()
  returns DzlProgressButton
  is native(dazzle)
  is export
{ * }

sub dzl_progress_button_set_progress (
  DzlProgressButton $button,
  guint             $percentage
)
  is native(dazzle)
  is export
{ * }

sub dzl_progress_button_set_show_progress (
  DzlProgressButton $button,
  gboolean          $show_progress
)
  is native(dazzle)
  is export
{ * }

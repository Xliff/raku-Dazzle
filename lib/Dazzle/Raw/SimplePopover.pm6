use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::SimplePopover;

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-simple-popover.h

sub dzl_simple_popover_get_button_text (DzlSimplePopover $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_get_message (DzlSimplePopover $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_get_ready (DzlSimplePopover $self)
  returns uint32
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_get_text (DzlSimplePopover $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_get_title (DzlSimplePopover $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_new ()
  returns DzlSimplePopover
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_set_button_text (
  DzlSimplePopover $self,
  Str              $button_text
)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_set_message (DzlSimplePopover $self, Str $message)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_set_ready (DzlSimplePopover $self, gboolean $ready)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_set_text (DzlSimplePopover $self, Str $text)
  is native(dazzle)
  is export
{ * }

sub dzl_simple_popover_set_title (DzlSimplePopover $self, Str $title)
  is native(dazzle)
  is export
{ * }

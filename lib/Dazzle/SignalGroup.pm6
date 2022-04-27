use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::SignalGroup;

use GLib::Roles::Object;

our subset DzlSignalGroupAncestry is export of Mu
  where DzlSignalGroup | GObject;

class Dazzle::SignalGroup {
  also does GLib::Roles::Object;

  has DzlSignalGroup $!dsg;

  submethod BUILD ( :$dzl-signal-group ) {
    self.setDzlSignalGroup($dzl-signal-group) if $dzl-signal-group;
  }

  method setDzlSignalGroup (DzlSignalGroupAncestry $_) {
    my $to-parent;

    $!dgm = do {
      when DzlSignalGroup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlSignalGroup, $_)
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlSignalGroup
  { $!dgm }

  multi method new (DzlSignalGroupAncestry $dzl-signal-group, :$ref = True) {
    return Nil unless $dzl-signal-group;

    my $o = self.bless( :$dzl-signal-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-signal-group = dzl_signal_group_new();

    $dzl-signal-group ?? self.bless( :$dzl-signal-group ) !! Nil;
  }

  method block {
    dzl_signal_group_block($!dsg);
  }

  method connect (
    Str      $detailed_signal,
    Pointer  $c_handler,
    gpointer $data             = gpointer
  ) {
    dzl_signal_group_connect($!dsg, $detailed_signal, $c_handler, $data);
  }

  method connect_after (
    Str      $detailed_signal,
    Pointer  $c_handler,
    gpointer $data             = gpointer
  ) {
    dzl_signal_group_connect_after($!dsg, $detailed_signal, $c_handler, $data);
  }

  method connect_data (
    Str()          $detailed_signal,
    Pointer        $c_handler,
    gpointer       $data,
    GClosureNotify $notify,
    Int()          $flags            = 0
  ) {
    my GConnectFlags $f = $flags;

    dzl_signal_group_connect_data(
      $!dsg,
      $detailed_signal,
      $c_handler,
      $data,
      $notify,
      $f
    );
  }

  method connect_object (
    Str           $detailed_signal,
    Pointer       $c_handler,
    GObject()     $object,
    Int()         $flags
  ) {
    my GConnectFlags $f = $flags;

    dzl_signal_group_connect_object(
      $!dsg,
      $detailed_signal,
      $c_handler,
      $object, $f
    );
  }

  method connect_swapped (
    Str()    $detailed_signal,
    Pointer  $c_handler,
    gpointer $data             = gpointer
  ) {
    dzl_signal_group_connect_swapped(
      $!dsg,
      $detailed_signal,
      $c_handler,
      $data
    );
  }

  method get_target ( :$raw = False ) {
    propReturnObject(
      dzl_signal_group_get_target($!dsg),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method set_target (GObject() $target) {
    dzl_signal_group_set_target($!dsg, $target);
  }

  method unblock {
    dzl_signal_group_unblock($!dsg);
  }

}

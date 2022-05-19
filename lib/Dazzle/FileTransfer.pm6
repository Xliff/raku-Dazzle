use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::FileTransfer;

use GLib::Value;

use GLib::Roles::Object;

our subset DzlFileTransferAncestry is export of Mu
  where DzlFileTransfer | GObject;

class Dazzle::FileTransfer {
  also does GLib::Roles::Object;

  has DzlFileTransfer $!dft is implementor;

  submethod BUILD ( :$dzl-file-transfer ) {
    self.setDzlFileTransfer($dzl-file-transfer) if $dzl-file-transfer;
  }

  method setDzlFileTransfer (DzlFileTransferAncestry $_) {
    my $to-parent;

    $!dft = do {
      when DzlFileTransfer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlFileTransfer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlFileTransfer
    is also<DzlFileTransfer>
  { $!dft }

  multi method new (
    DzlFileTransferAncestry  $dzl-file-transfer,
                               :$ref             = True
  ) {
    return Nil unless $dzl-file-transfer;

    my $o = self.bless( :$dzl-file-transfer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-file-transfer = dzl_file_transfer_new();

    $dzl-file-transfer ?? self.bless( :$dzl-file-transfer ) !! Nil;
  }

  # Type: DzlFileTransferFlags
  method flags is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(DzlFileTransferFlags) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('flags', $gv);
        DzlFileTransferFlagsEnum( $gv.valueFromEnum(DzlFileTransferFlags) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(DzlFileTransferFlags) = $val;
        self.prop_set('flags', $gv);
      }
    );
  }

  # Type: double
  method progress is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('progress', $gv);
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        warn 'progress does not allow writing'
      }
    );
  }

  method add (GFile() $src, GFile() $dest) {
    dzl_file_transfer_add($!dft, $src, $dest);
  }

  method execute (
    Int()                   $io_priority,
    GCancellable()          $cancellable  = GCancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gint $i = $io_priority;

    so dzl_file_transfer_execute($!dft, $io_priority, $cancellable, $error);
  }

  proto method execute_async (|)
    is also<execute-async>
  { * }

  multi method execute_async (
    Int()         $io_priority,
                  &callback,
    gpointer      $user_data    = gpointer,
    GCancellable :$cancellable  = GCancellable
  ) {
    samewith($io_priority, $cancellable, &callback, $user_data);
  }
  multi method execute_async (
    Int()        $io_priority,
    GCancellable $cancellable,
                 &callback,
    gpointer     $user_data
  ) {
    my gint $i = $io_priority;

    dzl_file_transfer_execute_async(
      $!dft,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method execute_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so dzl_file_transfer_execute_finish($!dft, $result, $error);
    set_error($error);
    $rv;
  }

  method get_flags ( :$set = False ) is also<get-flags> {
    my $f = dzl_file_transfer_get_flags($!dft);

    $set ?? getFlags(DzlFileTransferFlagsEnum, $f) !! $f;
  }

  method get_progress is also<get-progress> {
    dzl_file_transfer_get_progress($!dft);
  }

  method set_flags (Int() $flags) is also<set-flags> {
    my DzlFileTransferFlags $f = $flags;

    dzl_file_transfer_set_flags($!dft, $f);
  }

  method stat (Int() $stat_buf) {
    my DzlFileTransferStat $s = $stat_buf;

    dzl_file_transfer_stat($!dft, $s);
  }

}

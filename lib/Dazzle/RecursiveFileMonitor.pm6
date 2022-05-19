use v6.c;

use NativeCall;
use Method::Also;

use Dazzle::Raw::Types;
use Dazzle::Raw::RecursiveFileMonitor;

use GLib::Roles::Object;
use GIO::Roles::GFile;

use Dazzle::Roles::Signals::RecursiveFileMonitor;

our subset DzlRecursiveFileMonitorAncestry is export of Mu
  where DzlRecursiveFileMonitor | GObject;

class Dazzle::RecursiveFileMonitor {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Signals::RecursiveFileMonitor;

  has DzlRecursiveFileMonitor $!drfm is implementor;

  submethod BUILD ( :$dzl-recursive-file-monitor ) {
    self.setDzlRecursiveFileMonitor($dzl-recursive-file-monitor)
      if $dzl-recursive-file-monitor;
  }

  method setDzlRecursiveFileMonitor (DzlRecursiveFileMonitorAncestry $_) {
    my $to-parent;

    $!drfm  = do {
      when DzlRecursiveFileMonitor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlRecursiveFileMonitor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlRecursiveFileMonitor
    is also<DzlRecursiveFileMonitor>
  { $!drfm }

  multi method new (
    DzlRecursiveFileMonitorAncestry  $dzl-recursive-file-monitor,
                                    :$ref                         = True
  ) {
    return Nil unless $dzl-recursive-file-monitor;

    my $o = self.bless( :$dzl-recursive-file-monitor );
    $o.ref if $ref;
    $o;
  }
  multi method new (GFile() $root) {
    my $dzl-recursive-file-monitor = dzl_recursive_file_monitor_new($root);

    $dzl-recursive-file-monitor ?? self.bless( :$dzl-recursive-file-monitor )
                                !! Nil;
  }

  method changed {
    self.connect-dzl-changed($!drfm);
  }

  method cancel {
    dzl_recursive_file_monitor_cancel($!drfm);
  }

  method get_root ( :$raw = False ) is also<get-root> {
    propReturnObject(
      dzl_recursive_file_monitor_get_root($!drfm),
      $raw,
      |GIO::File.getTypePair
    );
  }

  multi method set_ignore_func (
             &ignore_func,
    gpointer $ignore_func_data         = gpointer,
             &ignore_func_data_destroy = Callable
  ) {
    dzl_recursive_file_monitor_set_ignore_func(
      $!drfm,
      &ignore_func,
      $ignore_func_data,
      &ignore_func_data_destroy
    );
  }

  proto method start_async (|)
    is also<start-async>
  { * }

   multi method start_async (
                    &callback,
    gpointer        $user_data    = gpointer,
    GCancellable() :$cancellable  = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method start_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    dzl_recursive_file_monitor_start_async(
      $!drfm,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method start_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so dzl_recursive_file_monitor_start_finish(
      $!drfm,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

}

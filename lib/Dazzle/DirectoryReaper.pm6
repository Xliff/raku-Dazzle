use v6.c;

use Method::Also;
use NativeCall;

use Dazzle::Raw::Types;
use Dazzle::Raw::DirectoryReaper;

use GLib::Roles::Object;
use Dazzle::Roles::Signals::DirectoryReaper;

our subset DzlDirectoryReaperAncestry is export of Mu
  where DzlDirectoryReaper | GObject;

class Dazzle::DirectoryReaper {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Signals::DirectoryReaper;

  has DzlDirectoryReaper $!ddr is implementor;

  submethod BUILD ( :$dzl-directory-reaper ) {
    self.setDzlDirectoryReaper($dzl-directory-reaper) if $dzl-directory-reaper;
  }

  method setDzlDirectoryReaper (DzlDirectoryReaperAncestry $_) {
    my $to-parent;

    $!ddr  = do {
      when DzlDirectoryReaper {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDirectoryReaper, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlDirectoryReaper
    is also<DzlDirectoryReaper>
  { $!ddr }

  multi method new (
    DzlDirectoryReaperAncestry  $dzl-directory-reaper,
                               :$ref                   = True
  ) {
    return Nil unless $dzl-directory-reaper;

    my $o = self.bless( :$dzl-directory-reaper );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-directory = dzl_directory_reaper_new();

    $dzl-directory ?? self.bless( :$dzl-directory ) !! Nil;
  }

  method remove-file is also<remove_file> {
    self.connect-file($!ddr, 'remove-file');
  }

  method add_directory (GFile() $directory, Int() $min_age)
    is also<add-directory>
  {
    my GTimeSpan $m = $min_age;

    dzl_directory_reaper_add_directory($!ddr, $directory, $m);
  }

  method add_file (GFile() $file, Int() $min_age) is also<add-file> {
    my GTimeSpan $m = $min_age;

    dzl_directory_reaper_add_file($!ddr, $file, $m);
  }

  method add_glob (GFile() $directory, Str $glob, Int() $min_age)
    is also<add-glob>
  {
    my GTimeSpan $m = $min_age;

    dzl_directory_reaper_add_glob($!ddr, $directory, $glob, $m);
  }

  method execute (
    GCancellable()          $cancellable,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    my $rv = so dzl_directory_reaper_execute($!ddr, $cancellable, $error);
    set_error($error);
    $rv
  }

  proto method execute_async (|)
    is also<execute-async>
  { * }

  multi method execute_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method execute_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data     = gpointer
  ) {
    dzl_directory_reaper_execute_async(
      $!ddr,
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
    my $rv = so dzl_directory_reaper_execute_finish($!ddr, $result, $error);
    set_error($error);
    $rv;
  }

}

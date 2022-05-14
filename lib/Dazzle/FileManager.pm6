use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::StaticClass;

class Dazzle::FileManager {
  also does GLib::Roles::StaticClass;

  method show (GFile() $file, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so dzl_file_manager_show($file, $error);
    set_error($error);
    $rv;
  }

}

### /usr/src/libdazzle-3.42.0/src/util/dzl-file-manager.h

sub dzl_file_manager_show (GFile $file, CArray[Pointer[GError]] $error)
  returns uint32
  is native(dazzle)
  is export
{ * }

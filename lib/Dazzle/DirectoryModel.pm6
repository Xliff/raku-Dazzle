use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::Object;
use GIO::Roles::ListModel;

our subset DzlDirectoryModelAncestry is export of Mu
  where DzlDirectoryModel | GListModel | GObject;

class Dazzle::DirectoryModel  {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;

  has DzlDirectoryModel $!ddm;

  submethod BUILD ( :$dzl-directory-model ) {
    self.setDzlDirectoryModel($dzl-directory-model) if $dzl-directory-model;
  }

  method setDzlDirectoryModel (DzlDirectoryModelAncestry $_) {
    my $to-parent;

    $!ddm = do {
      when DzlDirectoryModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $to-parent = cast(GObject, $_);
        $!lm = $_;
        cast(DzlDirectoryModel, $_)
      }

      default {
        $to-parent = $_;
        cast(DzlDirectoryModel, $_)
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
  }

  method Dazzle::Raw::Definitions::DzlDirectoryModel
  { $!ddm }

  multi method new (
    DzlDirectoryModelAncestry  $dzl-directory-model,
                              :$ref = True
   ) {
    return Nil unless $dzl-directory-model;

    my $o = self.bless( :$dzl-directory-model );
    $o.ref if $ref;
    $o;
  }
  multi method new (GFile() $directory) {
    my $dzl-directory-model = dzl_directory_model_new($directory);

    $dzl-directory-model ?? self.bless( :$dzl-directory-model ) !! Nil;
  }

  method get_directory ( :$raw = False ) {
    propReturnObject(
      dzl_directory_model_get_directory($!ddm),
      $raw,
      |GIO::GFile.getTypePair
    );
  }

  method set_directory (GFile() $directory) {
    dzl_directory_model_set_directory($!ddm, $directory);
  }

  method set_visible_func (
             &visible_func,
    gpointer $user_data           = gpointer,
             &user_data_free_func = Callable
  ) {
    dzl_directory_model_set_visible_func(
      $!ddm,
      &visible_func,
      $user_data,
      &user_data_free_func
    );
  }

}

### /usr/src/libdazzle-3.42.0/src/files/dzl-directory-model.h

sub dzl_directory_model_get_directory (DzlDirectoryModel $self)
  returns GFile
  is native(dazzle)
  is export
{ * }

sub dzl_directory_model_new (GFile $directory)
  returns DzlDirectoryModel
  is native(dazzle)
  is export
{ * }

sub dzl_directory_model_set_directory (
  DzlDirectoryModel $self,
  GFile             $directory
)
  is native(dazzle)
  is export
{ * }

sub dzl_directory_model_set_visible_func (
  DzlDirectoryModel $self,
                    &visible_func (
                      DzlDirectoryModel,
                      GFile,
                      GFileInfo,
                      gpointer
                      --> gboolean
                    ),
  gpointer          $user_data,
                    &user_data_free_func (gpointer)
)
  is native(dazzle)
  is export
{ * }

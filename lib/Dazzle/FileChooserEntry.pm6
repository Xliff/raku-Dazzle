use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Value;
use GTK::Bin;
use GTK::Entry;
use GTK::Widget;

use GIO::Roles::GFile;

class Dazzle::FileChooserEntry is GTK::Bin {
  has DzlFileChooserEntry $!dfce is implementor;

  multi method new (Str() $title, Int() $action) {
    my GtkFileChooserAction $a = $action;

    my $dzl-file-chooser-entry = dzl_file_chooser_entry_new($title, $a);

    $dzl-file-chooser-entry ?? self.bless( :$dzl-file-chooser-entry )
                            !! Nil;
  }

  # Type: GtkFileChooserAction
  method action is rw is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkFileChooserAction) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('action', $gv);
        GtkFileChooserActionEnum( $gv.valueFromEnum(GtkFileChooserAction) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GtkFileChooserAction) = $val;
        self.prop_set('action', $gv);
      }
    );
  }

  # Type: boolean
  method create-folders is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('create-folders', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('create-folders', $gv);
      }
    );
  }

  # Type: boolean
  method do-overwrite-confirmation is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('do-overwrite-confirmation', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('do-overwrite-confirmation', $gv);
      }
    );
  }

  # Type: boolean
  method local-only is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('local-only', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('local-only', $gv);
      }
    );
  }

  # Type: boolean
  method show-hidden is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('show-hidden', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-hidden', $gv);
      }
    );
  }

  # Type: GtkFileFilter
  method filter ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( GTK::FileFilter.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('filter', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GTK::FileFilter.getTypePair
        );
      },
      STORE => -> $, GtkFileFilter() $val is copy {
        $gv.object = $val;
        self.prop_set('filter', $gv);
      }
    );
  }

  # Type: DzlFile
  method file ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( GIO::File.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('file', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GIO::File.getTypePair
        );
      },
      STORE => -> $, GFile() $val is copy {
        $gv.object = $val;
        self.prop_set('file', $gv);
      }
    );
  }

  # Type: int
  method max-width-chars is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-width-chars', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('max-width-chars', $gv);
      }
    );
  }

  # Type: string
  method title is rw is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  method get_entry ( :$raw = False, :$widget = False ) {
    ReturnWidget(
      dzl_file_chooser_entry_get_entry($!dfce),
      $raw,
      $widget,
      base     => GTK::Entry
    )
  }

  method get_file ( :$raw = False ) {
    propReturnObject(
      dzl_file_chooser_entry_get_file($!dfce),
      $raw,
      |GIO::File.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_file_chooser_entry_get_type, $n, $t );
  }

  method set_file (GFile() $file) {
    dzl_file_chooser_entry_set_file($!dfce, $file);
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-file-chooser-entry.h

sub dzl_file_chooser_entry_get_entry (DzlFileChooserEntry $self)
  returns GtkEntry
  is native(dazzle)
  is export
{ * }

sub dzl_file_chooser_entry_get_file (DzlFileChooserEntry $self)
  returns GFile
  is native(dazzle)
  is export
{ * }

sub dzl_file_chooser_entry_new (Str $title, GtkFileChooserAction $action)
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

sub dzl_file_chooser_entry_set_file (DzlFileChooserEntry $self, GFile $file)
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_file_chooser_entry_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

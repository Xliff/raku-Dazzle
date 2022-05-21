use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::ListBox;

use GTK::ListBox;

use GIO::Roles::ListModel;

our subset DzlListBoxAncestry is export of Mu
  where DzlListBox | GtkListBoxAncestry;

class Dazzle::ListBox is GTK::ListBox {
  has DzlListBox $!dlb is implementor;

  submethod BUILD ( :$dzl-list-box ) {
    self.setDzlListBox($dzl-list-box) if $dzl-list-box;
  }

  method setDzlListBox (DzlListBoxAncestry $_) {
    my $to-parent;

    $!dlb = do {
      when DzlListBox  {
        $to-parent = cast(GtkListBox, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlListBox, $_);
      }
    }
    self.setGtkListBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlListBox
    is also<DzlListBox>
  { $!dlb }

  multi method new (DzlListBoxAncestry $dzl-list-box, :$ref = True) {
    return Nil unless $dzl-list-box;

    my $o = self.bless( :$dzl-list-box );
    $o.ref if $ref;
    $o
  }
  multi method new (Int() $row-type, Str() $property_name) {
    my GType $r = $row-type;

    my $dzl-list-box = dzl_list_box_new($r, $property_name);

    $dzl-list-box ?? self.bless( :$dzl-list-box ) !! Nil;
  }

  # Type: GType
  method row-type is rw is g-property is also<row_type> {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GTypeEnum) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('row-type', $gv);
        $gv.valueFromEnum(GTypeEnum);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GTypeEnum) = $val;
        self.prop_set('row-type', $gv);
      }
    );
  }

  # Type: string
  method row-type-name is rw is g-property is also<row_type_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        warn 'row-type-name does not allow reading' if $DEBUG;
        '';
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('row-type-name', $gv);
      }
    );
  }

  # Type: string
  method property-name is rw is g-property is also<property_name> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('property-name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('property-name', $gv);
      }
    );
  }

  method get_model ( :$raw = False ) is also<get-model> {
    propReturnObject(
      dzl_list_box_get_model($!dlb),
      $raw,
      |GIO::ListModel.getTypePair
    );
  }

  method get_property_name is also<get-property-name> {
    dzl_list_box_get_property_name($!dlb);
  }

  method get_row_type is also<get-row-type> {
    dzl_list_box_get_row_type($!dlb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_list_box_get_type, $n, $t );
  }

  method set_model (GListModel() $model) is also<set-model> {
    dzl_list_box_set_model($!dlb, $model);
  }

  method set_recycle_max (Int() $recycle_max) is also<set-recycle-max> {
    my guint $r = $recycle_max;

    dzl_list_box_set_recycle_max($!dlb, $r);
  }

}

use GTK::ListBoxRow;

our subset DzlListBoxRowAncestry is export of Mu
  where DzlListBoxRow | GtkListBoxRowAncestry;

class Dazzle::ListBox::Row is GTK::ListBoxRow {
  has DzlListBoxRow $!dlbr is implementor;

  submethod BUILD ( :$dzl-list-box-row ) {
    self.setDzlListBoxRow($dzl-list-box-row) if $dzl-list-box-row;
  }

  method setDzlListBox (DzlListBoxRowAncestry $_) {
    my $to-parent;

    $!dlbr = do {
      when DzlListBoxRow  {
        $to-parent = cast(GtkListBoxRow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlListBoxRow, $_);
      }
    }
    self.setGtkListBoxRow($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlListBoxRow
    is also<DzlListBoxRow>
  { $!dlbr }

  multi method new (DzlListBoxAncestry $dzl-list-box-row, :$ref = True) {
    return Nil unless $dzl-list-box-row;

    my $o = self.bless( :$dzl-list-box-row );
    $o.ref if $ref;
    $o
  }

  multi method new {
    my $dzl-list-box-row = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    $dzl-list-box-row ?? self.bless( :$dzl-list-box-row ) !! Nil;
  }

  method get_type is static is also<get-type>{
    state ($n, $t);

    unstable_get_type(self.^name, &dzl_list_box_row_get_type, $n, $t);
  }

}

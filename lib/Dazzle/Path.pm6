use v6.c;

use Method::Also;

use Dazzle::Raw::Types;
use Dazzle::Raw::Path;

use GLib::GList;

use GLib::Roles::Object;

our subset DzlPathAncestry is export of Mu
  where DzlPath | GObject;

class Dazzle::Path {
  also does GLib::Roles::Object;

  has DzlPath $!dp is implementor;

  submethod BUILD (:$dzl-path) {
    self.setDzlPath($dzl-path) if $dzl-path;
  }

  method setDzlPath (DzlPathAncestry $_) {
    my $to-parent;

    $!dp = do {
      when DzlPath {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPath, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPath
    is also<DzlPath>
  { $!dp }

  multi method new (DzlPathAncestry $dzl-path, :$ref = True) {
    return Nil unless $dzl-path;

    my $o = self.bless( :$dzl-path );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-path = dzl_path_new();

    $dzl-path ?? self.bless( :$dzl-path ) !! Nil;
  }

  method append (DzlPathElement() $element) {
    dzl_path_append($!dp, $element);
  }

  method get_element (Int() $index, :$raw = False) is also<get-element> {
    my guint $i = $index;

    propReturnObject(
      dzl_path_get_element($!dp, $index),
      $raw,
      |Dazzle::Path::Element.getTypePair
    );
  }

  method get_elements ( :$raw = False, :$glist = False )
    is also<
      get-elements
      elements
    >
  {
    returnGList(
      dzl_path_get_elements($!dp),
      $raw,
      $glist,
      |Dazzle::Path::Element.getTypePair
    );
  }

  method get_length
    is also<
      get-length
      length
      elems
    >
  {
    dzl_path_get_length($!dp);
  }

  method has_prefix (DzlPath() $prefix) is also<has-prefix> {
    so dzl_path_has_prefix($!dp, $prefix);
  }

  method is_empty is also<is-empty> {
    so dzl_path_is_empty($!dp);
  }

  method prepend (DzlPathElement() $element) {
    dzl_path_prepend($!dp, $element);
  }

  method printf is also<Str> {
    dzl_path_printf($!dp);
  }

}

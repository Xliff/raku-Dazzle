use v6.c;

use Method::Also;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Roles::Object;

our subset DzlPathElementAncestry is export of Mu
  where DzlPathElement | GObject;

class Dazzle::Path::Element {
  also does GLib::Roles::Object;

  has DzlPathElement $!dpe is implementor;

  submethod BUILD (:$dzl-path-element) {
    self.setDzlPathElement($dzl-path-element) if $dzl-path-element;
  }

  method setDzlPathElement (DzlPathElementAncestry $_) {
    my $to-parent;

    $!dpe = do {
      when DzlPathElement {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPathElement, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPathElement
  { $!dpe }

  multi method new (DzlPathElementAncestry $dzl-path-element, :$ref = True) {
    return Nil unless $dzl-path-element;

    my $o = self.bless( :$dzl-path-element );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $id, Str() $icon_name, Str() $title) {
    my $dzl-path-element = dzl_path_element_new($id, $icon_name, $title);

    $dzl-path-element ?? self.bless( :$dzl-path-element ) !! Nil;
  }

  method get_icon_name
    is also<
      get-icon-name
      icon_name
      icon-name
    >
  {
    dzl_path_element_get_icon_name($!dpe);
  }

  method get_id
    is also<
      get-id
      id
    >
  {
    dzl_path_element_get_id($!dpe);
  }

  method get_title
    is also<
      get-title
      title
    >
  {
    dzl_path_element_get_title($!dpe);
  }
}

### /usr/src/libdazzle-3.42.0/src/pathbar/dzl-path-element.h

sub dzl_path_element_get_icon_name (DzlPathElement $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_path_element_get_id (DzlPathElement $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_path_element_get_title (DzlPathElement $self)
  returns Str
  is native(dazzle)
  is export
{ * }

sub dzl_path_element_new (Str $id, Str $icon_name, Str $title)
  returns DzlPathElement
  is native(dazzle)
  is export
{ * }

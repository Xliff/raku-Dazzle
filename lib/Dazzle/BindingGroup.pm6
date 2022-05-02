use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::BindingGroup;

use GLib::Roles::Object;

our subset DzlBindingGroupAncestry is export of Mu
  when DzlBindingGroup | GObject;

class Dazzle::BindingGroup {
  also does GLib::Roles::Object;

  has DzlBindingGroup $!dbg is implementor;

  submethod BUILD (:$dzl-binding-group) {
    self.setDzlBindingGroup($dzl-binding-group) if $dzl-binding-group;
  }

  method setDzlBindingGroup (DzlBindingGroupAncestry $_) {
    my $to-parent;

    $!dbg = do {
      when DzlBindingGroup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlBindingGroup, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlBindingGroup
  { $!dbg }

  multi method new (DzlBindingGroupAncestry $dzl-binding-group, :$ref = True) {
    return Nil unless $dzl-binding-group;

    my $o = self.bless( :$dzl-binding-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-binding-group = dzl_binding_group_new();

    $dzl-binding-group ?? self.bless( :$dzl-binding-group ) !! Nil;
  }

  method bind (
    Str()     $source_property,
    GObject() $target,
    Str()     $target_property,
    Int()     $flags
  ) {
    my GBindingFlags $f = $flags;

    dzl_binding_group_bind(
      $!dbg,
      $source_property,
      $target,
      $target_property,
      $f
    );
  }

  method bind_full (
    Str()     $source_property,
    GObject() $target,
    Str()     $target_property,
    Int()     $flags,
              &transform_to,
              &transform_from,
    gpointer  $user_data,
              &user_data_destroy
  ) {
    my GBindingFlags $f = $flags;

    dzl_binding_group_bind_full(
      $!dbg,
      $source_property,
      $target,
      $target_property,
      $f,
      &transform_to,
      &transform_from,
      $user_data,
      &user_data_destroy
    );
  }

  method bind_with_closures (
    Str()      $source_property,
    GObject()  $target,
    Str()      $target_property,
    Int()      $flags,
    GClosure() $transform_to,
    GClosure() $transform_from
  ) {
    my GBindingFlags $f = $flags;

    dzl_binding_group_bind_with_closures(
      $!dbg,
      $source_property,
      $target,
      $target_property,
      $f,
      $transform_to,
      $transform_from
    );
  }

  method get_source ( :$raw = False ) {
    # cw: An opportunity to use %typeClass and late binding, here.
    propReturnObject(
      dzl_binding_group_get_source($!dbg),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method set_source (GObject() $source) {
    dzl_binding_group_set_source($!dbg, $source);
  }

}

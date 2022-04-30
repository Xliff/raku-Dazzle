use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::Stack;

use GTK::Box;

use Dazzle::Roles::Dock::Item;

our subset DzlDockStackAncestry is export of Mu
  where DzlDockStack | DzlDockItem | GtkBoxAncestry;

class Dazzle::Dock::Stack is GTK::Box {
  also does Dazzle::Roles::Dock::Item;

  has DzlDockStack $!dds is implementor;

  submethod BUILD ( :$dzl-dock-stack ) {
    self.setDzlDockStack($dzl-dock-stack) if $dzl-dock-stack;
  }

  method setDzlDockStack(DzlDockStackAncestry $_) {
    my $to-parent;

    $!dds = do {
      when DzlDockStack {
        $to-parent = cast(GtkBox, $_);
        $_;
      }

      when DzlDockItem {
        $to-parent = cast(GtkBox, $_);
        $!ddi      = $_;
        cast(DzlDockStack, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlDockStack, $_);
      }
    }
    self.setContainer($to-parent);
    self.roleInit-DzlDockItem;
  }

  method Dazzle::Raw::Definitions::DzlDockStack
  { $!dds }

  multi method new (DzlDockStackAncestry $dzl-dock-stack, :$ref = True) {
    return unless $dzl-dock-stack;

    my $o = self.bless( :$dzl-dock-stack );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-stack = dzl_dock_stack_new();

    $dzl-dock-stack ?? self.bless( :$dzl-dock-stack ) !! Nil;
  }

  # Type: DzlPositionType
  method edge is rw  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GtkPositionType) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'edge does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(GtkPositionType) = $val;
        self.prop_set('edge', $gv);
      }
    );
  }

  # Type: boolean
  method show-pinned-button is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        warn 'show-pinned-button does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-pinned-button', $gv);
      }
    );
  }

  # Type: DzlTabStyle
  method style is rw  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(DzlTabStyle) );
    Proxy.new(
      FETCH => sub ($) {
        warn 'style does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(DzlTabStyle) = $val;
        self.prop_set('style', $gv);
      }
    );
  }

  method get_edge {
    GtkPositionTypeEnum( dzl_dock_stack_get_edge($!dds) );
  }

  method get_show_pinned_button {
    so dzl_dock_stack_get_show_pinned_button($!dds);
  }

  method get_style {
    DzlTabStyleEnum( dzl_dock_stack_get_style($!dds) )
  }

  method set_edge (Int() $edge) {
    my GtkPositionType $e = $edge;

    dzl_dock_stack_set_edge($!dds, $e);
  }

  method set_show_pinned_button (Int() $show_pinned_button) {
    my gboolean $s = $show_pinned_button.Int.so;

    dzl_dock_stack_set_show_pinned_button($!dds, $s);
  }

  method set_style (Int() $style) {
    my DzlTabStyle $s = $style;

    dzl_dock_stack_set_style($!dds, $s);
  }

}

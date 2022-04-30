use v6.c;

use Dazzle::Raw::Types;

use GLib::Roles::Object;

role Dazzle::Roles::Dock {
  has DzlDock $!dd;

  method Dazzle::Raw::Definitions::DzlDock
  { $!dd }

  method roleInit-DzlDock {
    return if $!dd;

    my \i = findProperImplementor(self.^attributes);
    $!dd  = cast( DzlDock, i.get_value(self) );
  }

  # Type: DzlDockManager
  method manager is rw  {
    my $gv = GLib::Value.new( Dazzle::Dock::Manager.get_type );
    Proxy.new(
      FETCH => sub ($) {
        warn 'manager does not allow reading' if $DEBUG;
        0;
      },
      STORE => -> $, DzlDockManager() $val is copy {
        $gv.object = $val;
        self.prop_set('manager', $gv);
      }
    );
  }

}

our subset DzlDockAncestry is export of Mu
  where DzlDock | GObject;

class Dazzle::Dock {
  also does GLib::Roles::Object;
  also does Dazzle::Roles::Dock;

  submethod BUILD ( :$dzl-dock ) {
    self.setDzlDock($dzl-dock) if $dzl-dock;
  }

  method setDzlDock (DzlDockAncestry $_) {
    my $to-parent;

    $!dd = do {
      when DzlDock {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDock, $_);
      }

    }
    self!setObject($to-parent);
  }

  method new (DzlDockAncestry $dzl-dock, :$ref = True) {
    return Nil unless $dzl-dock;

    my $o = self.bless( :$dzl-dock );
    $o.ref if $ref;
    $o;
  }

}

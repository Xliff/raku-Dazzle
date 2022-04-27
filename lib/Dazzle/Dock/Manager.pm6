use v6.c;

use Dazzle::Raw::Types;
use Dazzle::Raw::Dock::Manager;

use GLib::Roles::Object;

our DzlDockManagerAncestry is export of Mu
  where DzlDockManager | GObject;

class Dazzle::Dock::Manager {
  also does GLib::Roles::Object;

  submethod BUILD ( :$dzl-animation ) {
    self.setDzlDockManager($dzl-animation) if $dzl-animation;
  }

  method setDzlDockManager (DzlDockManagerAncestry $_) {
    my $to-parent;

    $!da = do {
      when DzlDockManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlDockManager, $_)
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlDockManager
  { $!da }

  multi method new (DzlDockManagerAncestry $dzl-animation, :$ref = True) {
    return Nil unless $dzl-animation;

    my $o = self.bless( :$dzl-animation );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-dock-manager = dzl_dock_manager_new();

    $dzl-dock-manager ?? self.bless( :$dzl-dock-manager ) !! Nil;
  }

  # Is originally:
  # DzlDockManager *self,  DzlDock *dock --> void
  method register-dock {
    self.connect-dock($!ddm, 'register-dock');
  }

  # Is originally:
  # DzlDockManager *self,  DzlDock *dock --> void
  method unregister-dock {
    self.connect-dock($!ddm, 'unregister-dock');
  }

  method pause_grabs {
    dzl_dock_manager_pause_grabs($!ddm);
  }

  method emit_register_dock (DzlDock() $dock) {
    dzl_dock_manager_register_dock($!ddm, $dock);
  }

  method release_transient_grab {
    dzl_dock_manager_release_transient_grab($!ddm);
  }

  method unpause_grabs {
    dzl_dock_manager_unpause_grabs($!ddm);
  }

  method emit_unregister_dock (DzlDock() $dock) {
    dzl_dock_manager_unregister_dock($!ddm, $dock);
  }

}

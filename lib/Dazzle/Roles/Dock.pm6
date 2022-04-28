use v6.c;

use Dazzle::Raw::Types;

role Dazzle::Roles::Dock {

  # Type: DzlDockManager
  method manager is rw  {
    my $gv = GLib::Value.new( DzlDockManager );
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

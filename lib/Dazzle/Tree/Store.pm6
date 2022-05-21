use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GTK::TreeStore;

use GLib::Roles::Object;

our subset DzlTreeStoreAncestry is export of Mu
  where DzlTreeStore | GtkTreeStoreAncestry;

class Dazzle::Tree::Store is GTK::TreeStore {
  has DzlTreeStore $!dts is implementor;

  submethod BUILD ( :$dzl-tree-store ) {
    self.setDzlTreeStore($dzl-tree-store) if $dzl-tree-store;
  }

  method setDzlListBox (DzlTreeStoreAncestry $_) {
    my $to-parent;

    $!dts = do {
      when DzlTreeStore  {
        $to-parent = cast(GtkTreeStore, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlTreeStore, $_);
      }
    }
    self.setGtkTreeStore($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlTreeStore
    is also<DzlTreeStore>
  { $!dts }

  multi method new (DzlTreeStoreAncestry $dzl-tree-store, :$ref = True) {
    return Nil unless $dzl-tree-store;

    my $o = self.bless( :$dzl-tree-store );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-tree-store = ::?CLASS.new-object-ptr( ::?CLASS.get_type );

    $dzl-tree-store ?? self.bless( :$dzl-tree-store ) !! Nil;
  }

  method get_type is static is also<get-type> {
    state ($n, $t);

    unstable_get_type(self.^name, &dzl_tree_store_get_type, $n, $t);
  }

}

sub dzl_tree_store_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

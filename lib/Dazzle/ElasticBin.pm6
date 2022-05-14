use v6.c;

use Method::Also;

use NativeCall;

use Dazzle::Raw::Types;

use GTK::Bin;

our subset DzlElasticBinAncestry is export of Mu
  where DzlElasticBin | GtkBinAncestry;

class Dazzle::ElasticBin is GTK::Bin {
  has DzlElasticBin $!deb is implementor;

  submethod BUILD ( :$dzl-elastic-bin ) {
    self.setDzlElasticBin($dzl-elastic-bin) if $dzl-elastic-bin;
  }

  method setDzlElasticBin (DzlElasticBinAncestry $_) {
    my $to-parent;

    $!deb = do {
      when DzlElasticBin  {
        $to-parent = cast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlElasticBin, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlElasticBin
    is also<DzlElasticBin>
  { $!deb }

  multi method new (DzlElasticBinAncestry $dzl-elastic-bin, :$ref = True) {
    return Nil unless $dzl-elastic-bin;

    my $o = self.bless( :$dzl-elastic-bin );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-elastic-bin = dzl_elastic_bin_new();

    $dzl-elastic-bin ?? self.bless( :$dzl-elastic-bin ) !! Nil
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &dzl_elastic_bin_get_type, $n, $t );
  }

}

### /usr/src/libdazzle-3.42.0/src/widgets/dzl-elastic-bin.h

sub dzl_elastic_bin_new ()
  returns DzlElasticBin
  is native(dazzle)
  is export
{ * }

# Inferred

sub dzl_elastic_bin_get_type
  returns GType
  is export
  is native(dazzle)
{ * }

use v6.c;

use Dazzle::Raw::Types;

use Dazzle::Preferences::Bin;

our subset DzlPreferencesFlowBoxAncestry is export of Mu
  where DzlPreferencesFlowBox | DzlPreferencesBinAncestry;

class Dazzle::Preferences::FlowBox is Dazzle::Preferences::Bin {
  has DzlPreferencesFlowBox $!dpfb is implementor;

  submethod BUILD ( :$dzl-preferences-flow-box ) {
    self.setDzlPreferencesFlowBox($dzl-preferences-flow-box)
      if $dzl-preferences-flow-box
  }

  method setDzlPreferencesFlowBox (DzlPreferencesFlowBoxAncestry $_) {
    my $to-parent;

    $!dpfb = do {
      when DzlPreferencesFlowBox {
        $to-parent = cast(DzlPreferencesBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlPreferencesFlowBox, $_);
      }
    }
    self.setDzlPreferencesFlowBox($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlPreferencesFlowBox
  { $!dpfb }

  multi method new (
    DzlPreferencesFlowBoxAncestry  $dzl-preferences-flow-box,
                                  :$ref                      = False
  ) {
    return Nil unless $dzl-preferences-flow-box;

    my $o = self.bless( :$dzl-preferences-flow-box );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $dzl-preferences-flow-box = dzl_preferences_flow_box_new();

    $dzl-preferences-flow-box ?? self.bless( :$dzl-preferences-flow-box )
                              !! Nil;
  }

}

### /usr/src/libdazzle-3.42.0/src/prefs/dzl-preferences-flow-box.h

sub dzl_preferences_flow_box_new ()
  returns GtkWidget
  is native(dazzle)
  is export
{ * }

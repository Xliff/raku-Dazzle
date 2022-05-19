use v6.c;

use Dazzle::Raw::Types;

role DefaultValue[$v] {
  method default-value { $v }
}

role AttributeDescription[$d] {
  method attribute-description { $d }
}

role SummaryAttribute[$s] {
  method summary-text { $s }
}

role PreferencesWidget {
  has $!widget-id;

  method widget-id is rw {
    Proxy.new:
      FETCH => -> $            { $!widget-id },
      STORE => -> $, Int \wid  { $!widget-id = wid without $!widget-id };
  }

}

role PagedPreferencesWidget[$p] {
  method page { $p }
}

role GroupedPreferencesWidget[$g] {
  method group { $g }
}

role TitledPreferencesWidget[$t] {
  method title { $t }
}

role SubTitledPreferencesWidget[$s] {
  method subtitle { $s }
}

role SpinWidget   { }
role SwitchWidget { }

role KeywordsWidget[$k] {
  method keywords { $k }
}

role PriorityWidget[$p] {
  method priority { $p }
}

role PathedWidget[$p] {
  method path { $p }
}

role RadioWidget[@choices] {
  method choices { @choices }
}

role ListWidget[@choices] {
  method choices { @choices }
}

role CustomWidget[$widget] {
  method custom-widget { $widget }
}

role FileWidget       { }
role FontWidget       { }
role EntryWidget      { }

role PreferencesClass {

  method to-schema {
    sub to-key (Attribute $a) {
      my $kt = do given $a.type {
        when Int  { 'i' }
        when Str  { 's' }
        when Num  { 'd' }
        when Bool { 'b' }

        default   { 's' }
      }

      qq:to/KEY/;
            <key type="{ $kt }" name="{ $a.name.substr(2).lc }">
              <default>{     $a.?default-value         // ''}</default>
              <summary>{     $a.?summary-text          // '' }</summary>
              <description>{ $a.?attribute-description // '' }</description>
            </key>
        KEY
    }

    my $id = "org.gnome.{ self.^name.lc }";
    qq:to/XML/;
      <?xml version="1.0" encoding="UTF-8"?>
      <schemalist>
        <schema id="{$id}" path="{ $id.subst('.', '/', :g) }>
{ self.^attributes.map({ to-key($_) }).join('').chomp }
        </schema>
      </schemalist>
      XML
  }
}

multi sub trait_mod:<is> (Attribute \a, :$in-group!) is export {
  a does GroupedPreferencesWidget[$in-group.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$on-page!) is export {
  a does PagedPreferencesWidget[$on-page.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$titled!) is export {
  a does TitledPreferencesWidget[$titled.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> ( Attribute \a, :subtitled(:$sub-titled)! ) is export {
  a does SubTitledPreferencesWidget[$sub-titled.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$searched-on!) is export {
  a does KeywordsWidget[$searched-on.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$pathed!) is export {
  a does PathedWidget[$pathed.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> ( Attribute \a, :prioritized-as(:$priority)! ) is export {
  a does PriorityWidget[$priority.item];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :an-entry(:$entry) ) {
  a does EntryWidget;
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$file!) is export {
  a does FileWidget;
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$font!) is export {
  a does FontWidget;
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$radio!) is export {
  a does RadioWidget[$radio];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$list!) is export {
  a does ListWidget[$list];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$using-widget!) is export {
  a does CustomWidget[$using-widget];
  a does PreferencesWidget                    unless a ~~ PreferencesWidget;
}

multi sub trait_mod:<is> (Attribute \a, :$default-value!) {
  a does DefaultValue[$default-value];
}

multi sub trait_mod:<is> (Attribute \a, :$description!) {
  a does AttributeDescription[$description];
}

multi sub trait_mod:<is> (Attribute \a, :$summary!) {
  a does SummaryAttribute[$summary];
}

# The goal is:

class AppCharacteristics does PreferencesClass {
  my @model = <another list of choices>;

  #| === ID
  #| -- Grammar
  has Str $.title         is titled<My Title>
                          is summary('A title')
                          is description('A title of whatever you want titled');

  has Int $.number        is in-group<Generic Items>
                          is default-value(42);
  #| -- Math
  has Num $.pi            is priority(2);
  has Int $.choices       is radio<1 2 3>;

  #| === My_Model
  #| -- Locality
  has Int $.model-choices is radio(@model);
  has Str $.typeset       is font;
  #| -- Geography
  has Str $.location      is file;
  #| ====
  has Str $.not-paged;

  has Str $.this-parameter-should-be-buried-and-not-easily-found-by-users
     is on-page<This Page Should Never Be Found>
     is in-group<A hard to find group>
     is priority(-1000)
     is searched-on<pizza,peperoni,anchovies>
     is subtitled<Don't look here>;
}

class Dazzle::Preferences::Builder {

  has %!widgets;

  submethod BUILD ( :$view, :$class is copy ) {
    die 'Class cannot be Nil!'    unless $class !=== Nil;
    die 'Class cannot be a Cool!' unless $class !~~ Cool;

    $class .= new unless $class;

    my ($last-page, $last-group);
    for $class.^attributes {
      if .WHY.leading -> $why {
        if $why ~~ / '===' <.ws> (\w<[\w_\d]>+) / {
          ($last-page, $last-group) = ($0.Str, '');
        }

        if $why ~~ / '--' <.ws> (\w<[\w_\d]>+) / {
          $last-group = $0.Str;
        }

        if $why ~~ / '====' / {
          $last-group = $last-page = '';
        }
      }

      if $last-page {
        $_ does PagedPreferencesWidget[$last-page.item];
        $_ does PreferencesWidget unless $_ ~~ PreferencesWidget;
      }
      if $last-group {
        $_ does GroupedPreferencesWidget[$last-group.item];
        $_ does PreferencesWidget unless $_ ~~ PreferencesWidget;
      }

      next;

      my @e;
      my ($p, $g) = (.?page, .?group);
      @e.push: $p if $p;
      @e.push: $g if $g;

      # cw: Collision detection will be handled by the control.
      $view.add_page( $p )   if +@e;
      $view.add_group( |@e ) if +@e == 2;

      .widget-id = do {
        # Explicit determination
        when CustomWidget {
          # No validation performed. This is up to the consumer.
          $view.add_custom_widget(
            $p              // '',
            $g              // '',
            .custom.widget,
            .?keywords      // '',
            .?priority      // 0
          );
        }

        sub checkType ( $c, *@types ) {
          # cw: Attribute must be one of the listed types or have a
          #     new method that will accept one of the listed types.
          for @types {
            return True if .type ~~ $_;
            return True if .type.^lookup('new').grep( *.cando: \($class, $_) );
          }
          my $t = @types.map( *.^name ).join(', ');
          die "Attribute { .name } must be { $t } or have a .new that will {
               '' } will accept { @types.elems > 1 ?? 'either' !! 'it' } to {
               '' } use { $c }";
        }

        when EntryWidget {
          checkType('an Entry', Str, Int, Num);
        }

        when FontWidget {
          checkType('a FontButton', Str);

          $view.add_font_button(
            $p          // '',
            $g          // '',
            .?schema-id // '',
            .?key       // '',
            .?title     // '',
            .?keywords  // '',
            .?priority  // 0
          );
        }

        when FileWidget {
          checkType('a File Chooser', Str, IO::Path);

          # FileWidget -- action comes from trait.
          $view.add_file_chooser(
            $p          // '',
            $g          // '',
            .?schema-id // '',
            .?key       // '',
            .?path      // '',
            .?title     // '',
            .?subtitle  // '',
            .?action    // 0,
            .?keywords  // '',
            .?priority  // 0
          );
        }

        when ListWidget {
          checkType('a ListBox', Str, Int);

          # ListGroup -- Mode comes from trait.
          $view.add_list_group(
            $p          // '',
            $g          // '',
            .?title     // '',
            .?mode      // '',
            .?priority  // 0
          );
        }

        when SpinWidget {
          checkType('a SpinButton', Int);

          # Spinbutton
          $view.add_spin_button(
            $p          // '',
            $g          // '',
            .?schema-id // '',
            .?key       // '',
            .?path      // '',
            .?title     // '',
            .?subtitle  // '',
            .?keywords  // '',
            .?priority  // 0
          );
        }

        when RadioWidget {
          checkType('RadioGroup', Str, Int);
        }

        when SwitchWidget {
          checkType('a Switch', Str, Bool);

          # Switch
          $view.add_switch(
            $p          // '',
            $g          // '',
            .?schema-id // '',
            .?key       // '',
            .?path      // '',
            Str,
            .?title     // '',
            .?subtitle  // '',
            .?keywords  // '',
            .?priority  // 0
          );
        }

        default {

          # Determine by type
          do given .type {

            when Str | Num {
              # Entry
              my $entry = Dazzle::Preferences::Entry.new;
              $entry.title    = .?title    // '';
              $entry.subtitle = .?subtitle // '';

              $view.add_custom_widget(
                $p         // '',
                $g         // '',
                $entry,
                .?keywords // '',
                .?priority // 0
              );
            }

            when Int {
              # Spinbutton
              $view.add_spin_button(
                $p          // '',
                $g          // '',
                .?schema-id // '',
                .?key       // '',
                .?path      // '',
                .?title     // '',
                .?subtitle  // '',
                .?keywords  // '',
                .?priority  // 0
              );

            }

            when Bool {
              # Switch
              $view.add_switch(
                $p          // '',
                $g          // '',
                .?schema-id // '',
                .?key       // '',
                .?path      // '',
                Str,
                .?title     // '',
                .?subtitle  // '',
                .?keywords  // '',
                .?priority  // 0
              );
            }
          }

        }
      }
    }
  }

  multi method new (DzlPreferencesView() $view, :$class) {
    self.bless( :$view, :$class )
  }
  multi method new ($class) {
    self.bless( :$class );
  }

}

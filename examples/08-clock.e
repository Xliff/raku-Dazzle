use v6.c;

use DateTime::Format;

use GDK::Raw::Enums;

use GLib::Timeout;
use Dazzle::Augment::GTK;
use Dazzle::Application;
use Dazzle::Box;
use Dazzle::CSSProvider;
use Dazzle::SimpleLabel;

my $style;

my $a = Dazzle::Application.new('org.genex.dazzle.desktop.clock');
my $c = Dazzle::CSSProvider.new( pod => $=pod );

$a.activate.tap( -> *@a {
  my ($top, $mid, $bot) = Dazzle::SimpleLabel.new xx 3;
  my $box               = Dazzle::Box.new-vbox;

  for $top, $mid, $bot -> $_ is raw {
    .add-style-class( .VAR.name.substr(1) );
    .name eq 'labelmid' ?? $box.pack_start($_, True, True)
                        !! $box.pack_start($_, True);
  }

  (.type-hint, .decorated, .skip-taskbar-hint, .skip-pager-hint, .app-paintable) =
    (GDK_WINDOW_TYPE_HINT_NORMAL, True, False, False, True) given $a.window;
  $a.window.set_size_request(600, 300);
  $a.window.add($box);
  $a.window.show-all;

  $a.window.screen-changed.tap( -> *@a {
    if $a.window.get-screen.get-visual -> $v {
      $a.window.set-visual($v);
    }
  });
  # $a.window.draw.tap( -> *@a  {
  #   use Cairo;
  #
  #   my $c = Cairo::Context.new( @a[1] );
  #   $c.rgba(0, 0, 0, 0);
  #   $c.operator = OPERATOR_SOURCE;
  #   $c.paint;
  #   @a.tail.r = 1;
  # });

  sub displayDate {
    my $d = DateTime.now;

    $top.label = strftime('%A');
    $mid.label = strftime('%T');
    $bot.label = strftime('%B %m, %Y');
  }

  displayDate;

  GLib::Timeout.add(1000, -> *@a { displayDate; 1 });
});

$a.run;

=begin css
  applicationwindow  { background: rgba(1, 1, 1, 0) }

  label      { font-weight: bold;  }
  .top       { margin-top: 30px    }
  .mid       { font-size: 48px;    }
  .bot       { margin-bottom: 30px }
  .top, .bot { font-size: 36px     }
=end css

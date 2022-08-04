
use v6.c;
use DateTime::Format;

use GDK::Raw::Enums;

use GLib::Timeout;
use GDK::Visual;
use Dazzle::Augment::GTK;
use Dazzle::Box;
use GTK::CSSProvider;
use Dazzle::SimpleLabel;
use GTK::Application;

my $style;

my $a = GTK::Application.new(
  title       => 'org.genex.dazzle.desktop.clock',
  width       => 600,
  height      => 300,
  window-type => 'application'
);
my $c = GTK::CSSProvider.new( pod => $=pod );

$a.activate.tap( -> *@a {
  CATCH { default { .message.say; .backtrace.concise.say } }

  my ($top, $mid, $bot) = Dazzle::SimpleLabel.new xx 3;
  my $box               = Dazzle::Box.new-vbox;

  for $top, $mid, $bot -> $_ is raw {
    .add-style-class( .VAR.name.substr(1) );
    .name eq 'labelmid' ?? $box.pack_start($_, True, True)
                        !! $box.pack_start($_, True);
  }

  given $a.window {
    .type-hint         = GDK_WINDOW_TYPE_HINT_NORMAL,
    .decorated         = True,
    .skip-taskbar-hint = False,
    .skip-pager-hint   = False,
    .app-paintable     = True
  }

  $a.window.makeTransparent;

  $a.window.set_size_request(600, 300);
  $a.window.add($box);
  $a.window.show-all;

  $a.window.button-press-event.tap( -> *@a ($d1, $e, $d2, $r) {
    $a.window.decorated = $a.window.decorated.not
      if $e.type == GDK_DOUBLE_BUTTON_PRESS;
    $r.r = 1;
  });

  # $a.window.screen-changed.tap( -> *@a {
  #   CATCH { default { .message.say; .backtrace.concise.say } }
  #
  #   if $a.window.get-screen -> $s {
  #     say "S composited: { $s.is-composited }";
  #     if $s.get-rgba-visual -> $v {
  #       say "Setting visual to { $v.get_visual_type }";
  #
  #       $a.window.visual = $v;
  #     }
  #   }
  # });

  $a.window.draw.tap( -> *@a  {
    use GDK::Raw::Cairo;
    use GTK::Raw::Widget;

    CATCH { default { .message.say; .backtrace.concise.say } }

    # Change these to cairo raws.
    use Cairo;
    use GDK::Cairo;

    my $c = gdk_cairo_create( gtk_widget_get_window( @a[0].GtkWidget ) );
    $c.set_source_rgba(1.0.Num, 1.0.Num, 1.0.Num, 0.0.Num);
    $c.set_operator(OPERATOR_SOURCE.Int);
    $c.paint;
    #$c.destroy;

    #displayDate;
    @a.tail.r = 0;
  });

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
  label                  { font-weight: bold;  }
  .top                   { margin-top: 30px    }
  .mid                   { font-size: 48px;    }
  .bot                   { margin-bottom: 30px }
  .top, .bot             { font-size: 36px     }
=end css

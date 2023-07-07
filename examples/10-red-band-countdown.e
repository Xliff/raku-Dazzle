
use v6.c;
use DateTime::Format;

use GDK::Raw::Enums;
use GTK::Raw::Enums;

use GLib::Timeout;
use GDK::Display;
use GDK::Screen;
use GDK::Visual;
use GTK::Application;
use GTK::Button;
use GTK::CSSProvider;
use GTK::Dialog::Message;
use GTK::Entry;
use GTK::Label;
use Dazzle::Box;
use Dazzle::SimpleLabel;

use Dazzle::Additions::GTK;

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

  my $countdown = Dazzle::SimpleLabel.new;
  my $box       = Dazzle::Box.new-hbox;
  my $button    = GTK::Button.new-with-label('Set Duration');

  for $box, $countdown, $button -> $_ is raw {
    $_ does Dazzle::Additions::Widget;
    .add_style_class( .VAR.name.substr(1) );
   $box.pack_start($_, True) unless .VAR.name.substr(1) eq 'box'
  }

  given $a.window {
    .type-hint         = GDK_WINDOW_TYPE_HINT_NORMAL,
    .decorated         = True,
    .skip-taskbar-hint = False,
    .skip-pager-hint   = False,
    .app-paintable     = True
  }

  $a.window.makeTransparent(
    button-press => -> ($d1, $e, $d2) {
      $a.window.decorated = $a.window.decorated.not
        if $e.type == GDK_DOUBLE_BUTTON_PRESS;
      False;
    }
  );

  my $gdkScreen = GDK::Display.default.default-screen;

  $a.window.set_size_request($gdkScreen.width.pred, 100);
  $a.window.add($box);
  $a.window.show-all;

  $countdown.hide;

  my ($t, $d, $duration);

  sub displayDate {
    $d .= earlier( :1second );

    resetTimer if $d.minute == 0;

    $countdown.label = strftime('%T', $d);
  }

  $button.clicked.tap( -> *@a {
    CATCH {
      default { .message.say }
    }

    my $dialog     = GTK::Dialog::Message.new(
      buttons => GTK_BUTTONS_OK_CANCEL
    );
    my $area       = $dialog.content-area;
    my $vbox       = GTK::Box.new-vbox;
    my $entryLabel = GTK::Label.new('Enter Duration in minutes');
    my $minEntry   = GTK::Entry.new;

    # cw: I'll fix you later you &*(%^&%!
    #$dialog.default-widget = $entryLabel;

    $area.pack-end($_) for $minEntry, $entryLabel;

#    $vbox.pack-start($_) for $entryLabel, $minEntry;
#    $area.pack-start($vbox, True, True);

    $dialog.show_all;

    my $response = $dialog.run;

    if $response == GTK_RESPONSE_OK {
      CATCH {
        default {
          .message.say;
          $minEntry.text = '';
        }
      }

      say "D0";
      $button.hide;
      say "D0-B";
      $countdown.show;
      say "D0-C";

      $d = DateTime.new($minEntry.text.Num * 60);
      say "D0-D";

      $dialog.hide;
      say "D0-DH";
      displayDate;
      say "D0-DD";

      $t = GLib::Timeout.add(1000, -> *@a { displayDate; 1 });
      say "D1";
    }
  });

  sub resetTimer {
    $t.cancel;
    $countdown.hide;
    $button.show;
  }

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
});

$a.run;

=begin css
  label      { font-weight: bold;  }
  .countdown { font-size: 48px;    }
  .button    { }

  .box       {
    background-color: red;
    margin-top: 20px;
    margin-bottom: 20px;
  }
=end css

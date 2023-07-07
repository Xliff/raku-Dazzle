
use v6.c;
use DateTime::Format;

use GTK::Raw::Types;

use GLib::Timeout;
use GDK::Display;
use GDK::KeySyms;
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
    .decorated         = False,
    .skip-taskbar-hint = False,
    .skip-pager-hint   = False,
    .app-paintable     = True
  }

  $a.window.makeTransparent(
    button-press => -> *@a ($d1, $e, $d2) { False }
  );

  # cw: ESC with window in focus will exit.
  $a.window.key-press-event.tap( -> *@a ($, $e is copy, $, $r) {
    $e = cast(GdkEventKey, $e);

    if $e.keyval == GDK_KEY_Escape {
      $a.quit( :gio );
      $r.r = 1;
    } else {
      $r.r = 0;
    }
  });

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
    my $minEntry   = GTK::Entry.new.setAttributes(
      activates-default => True
    );

    my $okButton = $dialog.get_widget_for_response(GTK_RESPONSE_OK);
    $okButton.can-default = True;
    $okButton.grab-default;

    $area.pack-end($_) for $minEntry, $entryLabel;
    $dialog.show_all;

    my $response = $dialog.run;

    if $response == GTK_RESPONSE_OK {
      CATCH {
        default {
          .message.say;
          $minEntry.text = '';
        }
      }

      $button.hide;
      $countdown.show;

      $d = DateTime.new($minEntry.text.Num * 60);
      $dialog.hide;
      $box.replace_style_class('box', 'active-box');
      displayDate;

      $t = GLib::Timeout.add(1000, -> *@a { displayDate; 1 });
    }
  });

  sub resetTimer {
    $t.cancel;
    $countdown.hide;
    $button.show;
    $box.replace_style_class('active-box', 'box');
  }
});

$a.run;

=begin css
  label      { font-weight: bold;  }
  .countdown { font-size: 48px;    }

  .button    {
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .box {
    background-color: #008811;
  }

  .active-box {
    background-color: red;
  }
=end css

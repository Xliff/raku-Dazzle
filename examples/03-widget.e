use v6.c;

use Test;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Timeout;
use GTK::Button;
use GTK::Box;
use GTK::CSSProvider;
use Dazzle::Application;
use Dazzle::Augment::GTK;
use Dazzle::PillBox;

# my $a = GTK::Application.new(
#   title  => 'org.genex.dazzle.widget.test',
#   width  => 400,
#   height => 400,
# );
my $a   = Dazzle::Application.new('org.genex.dazzle.widget.test');
my $css = GTK::CSSProvider.new( pod => $=pod );

$a.activate.tap(-> *@a {
  $a.wait-for-init;

  my $p-box = Dazzle::PillBox.new('A Surrounding Box');
  my $box   = $p-box.get-child;
  $box.orientation = GTK_ORIENTATION_VERTICAL;
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );
  ($b1.name, $b2.name, $b3.name) = ('button1', 'button2', 'button3');
  # Not as self-documenting, but does the same thing as ↑↑↑↑:
  #    ('button' xx 3) Z~ (1..3).list

  $b1.clicked.tap(-> *@a { say 'Click me button was clicked'; });
  $b2.clicked.tap(-> *@a { say 'Open button was clicked'; });
  $b3.clicked.tap(-> *@a { say 'Closing application.'; $a.exit( :gio ); });
  $box.pack_start($b1, True, True, 0);
  $box.pack_start($b2, True, True, 0);
  $box.pack_start($b3, True, True, 0);
  $a.window.add($p-box);
  $a.window.show_all;
  $p-box.hide;

  GLib::Timeout.add(2000, -> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } };

    $p-box.show-with-fade;
    0;
  });
});

$a.run;

=begin css
button {
  border-width: 5px;
  border-color: #333333;
  border-radius: 10px;
  background: #11ccff;
  margin: 10px;
  color: #000;
}

button:hover {
  background: #1166ff;
  color: #fff;
}

#button1 {
  font-family: Times New Roman;
}

#button2 {
  font-weight: bold;
}

#button3 {
  font-family: FreeSans;
  font-style: italic;
}
=end css

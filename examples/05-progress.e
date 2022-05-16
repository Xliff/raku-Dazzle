use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Timeout;
use GTK::Button;
use GTK::Box;
use GTK::CSSProvider;
use Dazzle::Application;
use Dazzle::ProgressButton;
use Dazzle::ProgressIcon;

my $a   = Dazzle::Application.new('org.genex.dazzle.widget.test');

$a.activate.tap(-> *@a {
  $a.wait-for-init;

  my $box    = GTK::Box.new-vbox(6);
  my $button = Dazzle::ProgressButton.new;
  my $icon   = Dazzle::ProgressIcon.new;

  $button.label         = 'My progress...';
  $button.show-progress = True;
  $box.pack-start($button, True);
  $box.pack-start($icon, True, True);

  $a.window.add($box);
  $a.window.show-all;

  my $progress   = $button.progress = 0;
  $icon.progress = 1;

  GLib::Timeout.add( 1000, -> *@a {

    GLib::Timeout.add( (^50).pick, -> *@a {
      CATCH { default { .message.say } }

      say "Progress: { $button.progress = ++$progress }";
      $icon.progress = 1 - $progress / 100;

      $progress >= 100 ?? 0 !! 1 # Go again if not filled
    });

    0
  })
});

$a.run;

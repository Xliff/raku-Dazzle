use v6.c;

use GTK::Box;
use GTK::Overlay;
use Dazzle::CSSProvider;
use Dazzle::Application;
use Dazzle::Graph::CPU;
use Dazzle::SimpleLabel;

sub MAIN {
  Dazzle::Application.init;

  # my $a = Dazzle::Application.new(
  #   title  => 'org.genex.dazzle.cpu',
  #   width  => 1024,
  #   height => 768
  # );
  my $a = Dazzle::Application.new('org.genex.dazzle.cpu');
  my $c = Dazzle::CSSProvider.new( pod => $=pod );

  say "DA: { $a }";

  sub mq ($s, $l = '-') {
    $s ~ "\n" ~ ($l x $s.chars)
  }

  $a.activate.tap(-> *@a {
    my $o = GTK::Overlay.new;
    my $g = Dazzle::Graph::CPU.new;
    my $b = GTK::Box.new-vbox;

    $o.add($g);
    $o.add_overlay($b);

    my $l = Dazzle::SimpleLabel('CPUGraph');
    $l.xalign = 0.5;
    $b.pack-start($l, True, True);

    # my %cpu-p = $g.getClass.getProperties;
    # say 'CPU Properties'.&mq;
    # say "# properties: { %cpu-p.elems }";
    # say "Property list:\n\t{ %cpu-p.keys.join("\n\t") }";

    # my %sl-p = $l.getClass.getProperties;
    # say 'SimpleLabel Properties'.&mq;
    # say "# properties: { %sl-p.elems }";
    # say "Property list:\n\t{
    #      my $c = 1;
    #      %sl-p.keys.sort.map({ "{$c++}) $_" }).join("\n\t") }";

    $a.window.add($o);
    $a.window.show-all;
  });

  $a.run;
}

=begin css
label {
  color: #ffffff;
  text-shadow: 2px 2px #00cccc;
  font-size: 36px;
}
=end css

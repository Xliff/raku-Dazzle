use v6.c;

use GTK::Application;
use Dazzle::Graph::CPU;

sub MAIN {
  my $a = GTK::Application.new(
    title  => 'org.genex.dazzle.cpu',
    width  => 1024,
    height => 768
  );

  $a.activate.tap(-> *@a {
    my $g = Dazzle::Graph::CPU.new;

    my %p = $g.getClass.getProperties;

    say "# properties: { %p.elems }";

    say "Property list:\n\t{ %p.keys.join("\n\t") }";

    $a.window.add($g);

    $a.window.show-all;
  });

  $a.run;
}

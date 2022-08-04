use v6.c;

use Test;

use Dazzle::Raw::Types;

use Dazzle::Fuzzy::Mutable::Index;

use GIO::Roles::File;

sub MAIN (
  *@words = <these are the default words>,
  :$path  = 'test-fuzzy-mutable-index.txt'
) {

  my $f = GIO::File.new_for_path($path);
  my $d = GIO::DataInputStream( $f.read( :raw ) );

  $f.begin-bulk-insert;
  while $d.read-line -> $_ {
    $f.index-insert($_, $_);
  }
  $f.end-bulk-insert;

  for @words {
    diag "Searching for: { $_ }";

    my $matches = $f.match($_);
    my $dur     = now - ENTER now;

    for $matches.sort {
      my $fim = Dazzle::Fuzzy::Mutable::Index::Match.new($_);
      diag "    { $fim.score.fmt('%.4f') } : { $fim.key }";

      is   $match.key, $match.value,    "Match key is the same as its value";
    }

    diag "Completed query in: { $dur }s";
  }

  $f.unref;

}

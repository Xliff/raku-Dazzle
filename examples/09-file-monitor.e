use v6;

use Dazzle::Raw::Types;

use GLib::Timeout;
use Dazzle::Application;
use Dazzle::RecursiveFileMonitor;

use GIO::Roles::GFile;

sub getFileName ( :$ext = True ) {
  my @letters = ('a'..'z');

  @letters.pick(8).join ~
  ($ext ?? '.' ~ @letters.pick(3).join !! '')
}

sub random-pause ($max, $min = 1) {
  sleep ($min..$max).pick;
}

enum Operation <ADD CHANGE DEL MKDIR>;

sub getNextOperation {
  once { return ADD }

  Operation.enums.pick.value
}

my $a = Dazzle::Application.new('org.genex.dazzle.recursive-monitor');

my $test-directory = 'recursive-dzl-fam';
$a.activate.tap( -> *@a {
  my $tdi = $*CWD.add($test-directory);
  $tdi.mkdir unless $tdi.r;

  my $rfam = Dazzle::RecursiveFileMonitor.new($tdi);

  $rfam.changed.tap( -> *@b {
    CATCH { default { .message.say } }

    my $fo = GIO::File.new( @b[1] );
    my $fi = $fo.query_info;

    say "»»»»»» Event { GFileMonitorEventEnum( @b[3] ) } detected on file {
         $fo.get_basename }";
  });

  signal(SIGINT).tap({
    qqx«rm -rf { $tdi.absolute }»;
    say "\n\nAll test files removed!";
    $rfam.cancel;
    $a.exit;
    exit 0;
  });

  $rfam.start-async;

  say 'Monitor started. Setting timeout....';

  my (@dirs, @files);
  GLib::Timeout.add(1, -> *@a {
    CATCH { default { .message.say } }

    given getNextOperation() {
      say "{ Operation( $_ ).key } ({ $*CWD.absolute })";

      when ADD {
        unless @dirs {
          ( my $nd = $tdi.add('dir1') ).mkdir;
          @dirs.push: $nd;
        }

        for (3..5).pick {
          my $new-file-io = @dirs.pick.add( getFileName );
          $new-file-io.spurt: 'Test';
          @files.push: $new-file-io;
          say "Adding { @files.tail }...";
          random-pause(3);
        }
      }

      when CHANGE {
        if +@files {
          my $f = @files.pick;

          $f.spurt: $f.slurp ~
                    # cw: Random text, use what's available
                    getFileName( :!ext ) x (1..^5).pick;
        }
      }

      when DEL {
        if +@files {
          for (1 ..^ @files).pick {
            my $f = @files.pick;
            @files .= grep({ $_ !=== $f });
            $f.unlink;
            random-pause(3);
          }
        }
      }

      when MKDIR {
        @dirs.push: $tdi.add( getFileName( :!ext ) );
        @dirs.tail.mkdir;
      }

    }
    random-pause(3);

    1;
  });
});

$a.run;

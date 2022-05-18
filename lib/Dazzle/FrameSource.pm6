use v6.c;

use NativeCall;

use Dazzle::Raw::Types;

use GLib::Source;

our subset DzlFrameSourceAncestry is export of Mu
  where DzlFrameSource | GSource;

class Dazzle::FrameSource is GLib::Source {
  has DzlFrameSource $!dfs is implementor;

  submethod BUILD ( :$frame-source ) {
    self.setDzlFrameSource($frame-source) if $frame-source;
  }

  method setDzlFrameSource (DzlFrameSourceAncestry $_) {
    my $to-parent;

    $!dfs = do {
      when DzlFrameSource {
        $to-parent = cast(GSource, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlFrameSource, $_);
      }
    }
    self.setGSource($to-parent);
  }

  method Dazzle::Raw::Structs::DzlFrameSource
  { $!dfs }

  multi method new (DzlFrameSourceAncestry $dzl-frame-source, :$ref = True) {
    return Nil unless $dzl-frame-source;

    my $o = self.bless($dzl-frame-source);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    samewith( DzlFrameSource.new )
  }

  method add (&callback, gpointer $user_data = gpointer) {
    dzl_frame_source_add($!dfs, &callback, $user_data);
  }

  method add_full (
    Int()    $frames_per_sec,
             &callback,
    gpointer $user_data,
             &notify = Callable
  ) {
    my guint $f = $frames_per_sec;

    dzl_frame_source_add_full($!dfs, $f, &callback, $user_data, &notify);
  }
}

### /usr/src/libdazzle-3.42.0/src/animation/dzl-frame-source.h

sub dzl_frame_source_add (
  guint    $frames_per_sec,
           &callback (gpointer --> gboolean),
  gpointer $user_data
)
  returns guint
  is native(dazzle)
  is export
{ * }

sub dzl_frame_source_add_full (
  gint     $priority,
  guint    $frames_per_sec,
           &callback (gpointer --> gboolean),
  gpointer $user_data,
           &notify (gpointer)
)
  returns guint
  is native(dazzle)
  is export
{ * }

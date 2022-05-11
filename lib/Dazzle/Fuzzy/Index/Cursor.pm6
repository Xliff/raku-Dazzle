use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;

use GLib::Roles::Object;
use GIO::Roles::ListModel;
use GIO::Roles::AsyncInitable;

our subset DzlFuzzyIndexCursorAncestry is export of Mu
  where DzlFuzzyIndexCursor | GListModel | GAsyncInitable | GObject;

class Dazzle::Fuzzy::Index::Cursor {
  also does GLib::Roles::Object;
  also does GIO::Roles::ListModel;
  also does GIO::Roles::AsyncInitable;

  has DzlFuzzyIndexCursor $!dfic is implementor;

  submethod BUILD ( :$dzl-fuzzy-index-cursor ) {
    self.setDzlFuzzyIndexCursor($dzl-fuzzy-index-cursor) if $dzl-fuzzy-index-cursor;
  }

  method setDzlFuzzyIndexCursor (DzlFuzzyIndexCursorAncestry $_) {
    my $to-parent;

    $!dfic = do {
      when DzlFuzzyIndexCursor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GListModel {
        $to-parent = cast(GObject, $_);
        $!lm       = $_;
        cast(DzlFuzzyIndexCursor, $_);
      }

      when GAsyncInitable {
        $to-parent = cast(GObject, $_);
        $!ai       = $_;
        cast(DzlFuzzyIndexCursor, $_);
      }

      default {
        $to-parent = $_;
        cast(DzlFuzzyIndexCursor, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GListModel;
    self.roleInit-GAsyncInitable;
  }

  method Dazzle::Raw::Definitions::DzlFuzzyIndexCursor
  { $!dfic }

  multi method new (
    DzlFuzzyIndexCursorAncestry  $dzl-fuzzy-index-cursor,
                                :$ref                     = True
  ) {
    return Nil unless $dzl-fuzzy-index-cursor;

    my $o = self.bless( :$dzl-fuzzy-index-cursor );
    $o.ref if $ref;
    $o;
  }

  # Type: boolean
  method case-sensitive is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('case-sensitive', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'case-sensitive is a construct-only attribute'
      }
    );
  }

  # Type: uint
  method max-matches is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('max-matches', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'max-matches is a construct-only attribute'
      }
    );
  }

  # Type: string
  method query is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('query', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'query is a construct-only attribute'
      }
    );
  }

  method get_index {
    dzl_fuzzy_index_cursor_get_index($!dfic);
  }

}

### /usr/src/libdazzle-3.42.0/src/search/dzl-fuzzy-index-cursor.h

sub dzl_fuzzy_index_cursor_get_index (DzlFuzzyIndexCursor $self)
  returns DzlFuzzyIndexCursor
  is native(dazzle)
  is export
{ * }

use v6.c;

use Test;

use Dazzle::Raw::Types;

use Dazzle::Fuzzy::Mutable::Index;

my @tests = (
  [ 'with <Tab>',        'with tab',  '<b>with </b>&lt;<b>Tab</b>&gt;'       ],
  [ 'with <Tab>',        'with t',    '<b>with </b>&lt;<b>T</b>ab&gt;'       ],
  [ 'with &apos; stuff', 'with tuff', '<b>with </b>&apos; s<b>tuff</b>'      ],
  [ 'gtk_widget_show',   'gtkwdg',    '<b>gtk</b>_<b>w</b>i<b>dg</b>et_show' ]
);

plan @tests.elems;

for @tests {
  my $highlight = search-highlight( |$_[^2], False );
  is $highlight,  .tail,            'Highlighted text matches expectations';
}

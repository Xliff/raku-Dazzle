=BEGIN

cw:

To begin with, DazzleCounters are generic counters.

A DazzleArena is a collection of DazzleCounters

The tricky part is their creation. They are supposed to be created
with an byte-alignment of 8.

This will be tricky with Raku/NativeCall, which doesn't know of such
things.

The best workaround is to add this creation to a support library
which will respect the _alignment_attribute and use that via
NativeCall.

Until that is done, it is best that these classes remain NYI.

=END

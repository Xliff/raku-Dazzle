use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

constant dazzle is export = 'dazzle-1',v0;

class DzlGraphColumn        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphModel         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphView          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphRenderer      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFlowBox is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutChordTable is repr<CPointer> does GLib::Roles::Pointers is export { }

class DazzleGraphView       is repr<CPointer> does GLib::Roles::Pointers is export { }
class DazzleCPUGraph        is repr<CPointer> does GLib::Roles::Pointers is export { }

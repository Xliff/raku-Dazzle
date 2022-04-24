use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions;
use Dazzle::Raw::Definitions;
use Dazzle::Raw::Enums;

unit package Dazzle::Raw::Structs;

class DzlFuzzyMutableIndexMatch is repr<CStruct> is export {
	has Str      $.key  ;
	has gpointer $.value;
	has gfloat   $.score;
	has guint    $.id   ;
}

class DzlHeap is repr<CStruct> is export {
	has Str   $.data;
	has gsize $.len ;
}

class DzlGraphModelIter is repr<CStruct> is export {
  HAS gpointer @.data[8] is CArray;
}

class DzlIntPair is repr<CStruct> is export {
	has gint $.first  is rw;
	has gint $.second is rw;
}

class DzlUIntPair is repr<CStruct> is export {
	has guint $.first  is rw;
	has guint $.second is rw;
}

class DzlPreferencesPage is repr<CStruct> is export {
	has GtkBin                $!parent_instance;
	has gint                  $!priority       ;
	has DzlPreferencesFlowBox $!box            ;
	has GHashTable            $!groups_by_name ;
}

class DzlRing is repr<CStruct> is export {
	has CArray[guint8] $.data;
	has guint          $.len ;
	has guint          $.pos ;
}

class DzlShortcutChordTableIter is repr<CStruct> is export {
	has DzlShortcutChordTable $!table   ;
	has guint                 $!position;
}

class DzlShortcutEntry is repr<CStruct> is export {
	has Str              $!command      ;
	has DzlShortcutPhase $!phase        ;
	has Str              $!default_accel;
	has Str              $!section      ;
	has Str              $!group        ;
	has Str              $!title        ;
	has Str              $!subtitle     ;
}

class DzlShortcutNodeData is repr<CStruct> is export {
	has DzlShortcutNodeType $!type    ;
	has guint               $!magic   ;
	has Str                 $!name    ;
	has Str                 $!title   ;
	has Str                 $!subtitle;
}

class DzlShortcutsWindow is repr<CStruct> is export {
	has GtkWindow $!window;
}

class action is repr<CStruct> is export {
	has Str      $!group ;
	has Str      $!name  ;
	has GVariant $!params;
}

class callback is repr<CStruct> is export {
	has Pointer   $!callback ;
	has gpointer  $!user_data;
	has Pointer   $!notify   ;
}

class command is repr<CStruct> is export {
	has Str $!name;
}

class signal is repr<CStruct> is export {
	has GQuark $!detail;
	has Str    $!name  ;
	has GArray $!params;
}

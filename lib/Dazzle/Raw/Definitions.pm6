use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Object;

use GDK::RGBA;

use GLib::Roles::Pointers;

constant dazzle is export = 'dazzle-1.0',v0;

class DzlAnimation                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlApplication                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlApplicationWindow            is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBin                          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBindingGroup                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBox                          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlBoldingLabel                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlCenteringBin                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlColumnLayout                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDirectoryModel               is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDock                         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockBin                      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockItem                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockManager                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockOverlay                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockOverlayEdge              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockRevealer                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockStack                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockWidget                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockWindow                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlElasticBin                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlEmptyState                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlEntryBox                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlFileChooserEntry             is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlFuzzyIndex                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlFuzzyIndexCursor             is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphColumn                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphModel                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphRenderer                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlGraphView                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlJoinedMenu                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlListBox                      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlListBoxRow                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuButton                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuButtonSection            is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMenuManager                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlMultiPaned                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPath                         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPathBar                      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPathElement                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPillBox                      is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferences                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesBin               is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesEntry             is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFileChooserButton is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFlowBox           is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesFontButton        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesGroup             is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesSpinButton        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesSwitch            is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPreferencesView              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlPriorityBox                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutChord                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutChordTable           is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutContext              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutController           is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutLabel                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutManager              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutModel                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutsGroup               is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutSimpleLabel          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutTheme                is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutThemeEditor          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlShortcutTooltip              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSignalGroup                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlStateMachine                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSuggestion                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSuggestionEntry              is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSuggestionEntryBuffer        is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlSuggestionPopover            is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlTab                          is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlTabStrip                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlThemeManager                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlTree                         is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlTreeBuilder                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlTreeNode                     is repr<CPointer> does GLib::Roles::Pointers is export { }
class DzlDockTransientGrab            is repr<CPointer> does GLib::Roles::Pointers is export { }

class DazzleGraphView                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class DazzleCPUGraph                  is repr<CPointer> does GLib::Roles::Pointers is export { }

class DzlGraphLineRenderer is repr<CStruct> does GLib::Roles::Pointers is export {
  HAS GObject $.parent;
  HAS GdkRGBA $!stroke-color;
  has gdouble $.line-width    is rw;
  has guint   $.column        is rw;

  method stroke_color is also<stroke-color> is rw {
    Proxy.new:
      FETCH => -> $               { $.stroke-color },

      STORE => -> $, GdkRGBA() $v {
        $!stroke-color.r = $v.r;
        $!stroke-color.g = $v.g;
        $!stroke-color.b = $v.b;
        $!stroke-color.a = $v.a;
      }
  }

  method line_width is rw { $!line-width }
}

class DzlPatternSpec is repr<CStruct> does GLib::Roles::Pointers is export {
  has gint        $!ref-count;
  has Str         $!needle;
  has CArray[Str] $!parts;
  has guint       $!flags;
}

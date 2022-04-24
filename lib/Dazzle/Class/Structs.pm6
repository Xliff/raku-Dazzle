class DzlBinClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
}

class DzlBoxClass is repr<CStruct> is export {
	has GtkBoxClass $!parent_class;
}

class DzlSearchBarClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
}

class DzlCenteringBinClass is repr<CStruct> is export {
	has GtkBinClass $!parent;
}

class DzlColumnLayoutClass is repr<CStruct> is export {
	has GtkContainerClass $!parent;
}

class DzlCountersWindowClass is repr<CStruct> is export {
	has GtkWindowClass $!parent_class;
	has gpointer       $!_reserved1  ;
	has gpointer       $!_reserved2  ;
	has gpointer       $!_reserved3  ;
	has gpointer       $!_reserved4  ;
}

class DzlDockPanedClass is repr<CStruct> is export {
	has DzlMultiPanedClass $!parent    ;
	has gpointer           $!_reserved1;
	has gpointer           $!_reserved2;
	has gpointer           $!_reserved3;
	has gpointer           $!_reserved4;
	has gpointer           $!_reserved5;
	has gpointer           $!_reserved6;
	has gpointer           $!_reserved7;
	has gpointer           $!_reserved8;
}

class DzlDockRevealerClass is repr<CStruct> is export {
	has DzlBinClass $!parent    ;
	has gpointer    $!_reserved1;
	has gpointer    $!_reserved2;
	has gpointer    $!_reserved3;
	has gpointer    $!_reserved4;
	has gpointer    $!_reserved5;
	has gpointer    $!_reserved6;
	has gpointer    $!_reserved7;
	has gpointer    $!_reserved8;
}

class DzlDockStackClass is repr<CStruct> is export {
	has GtkBoxClass $!parent    ;
	has gpointer    $!_reserved1;
	has gpointer    $!_reserved2;
	has gpointer    $!_reserved3;
	has gpointer    $!_reserved4;
}

class DzlDockWidgetClass is repr<CStruct> is export {
	has DzlBinClass $!parent    ;
	has gpointer    $!_reserved1;
	has gpointer    $!_reserved2;
	has gpointer    $!_reserved3;
	has gpointer    $!_reserved4;
	has gpointer    $!_reserved5;
	has gpointer    $!_reserved6;
	has gpointer    $!_reserved7;
	has gpointer    $!_reserved8;
}

class DzlDockWindowClass is repr<CStruct> is export {
	has GtkWindowClass $!parent    ;
	has gpointer       $!_reserved1;
	has gpointer       $!_reserved2;
	has gpointer       $!_reserved3;
	has gpointer       $!_reserved4;
	has gpointer       $!_reserved5;
	has gpointer       $!_reserved6;
	has gpointer       $!_reserved7;
	has gpointer       $!_reserved8;
}

class DzlElasticBinClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
	has gpointer    $!_reserved1  ;
	has gpointer    $!_reserved2  ;
	has gpointer    $!_reserved3  ;
	has gpointer    $!_reserved4  ;
}

class DzlEmptyStateClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
}

class DzlFileChooserEntryClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
	has gpointer    $!_reserved1  ;
	has gpointer    $!_reserved2  ;
	has gpointer    $!_reserved3  ;
	has gpointer    $!_reserved4  ;
}

class DzlGraphColumnClass is repr<CStruct> is export {
	has GObjectClass $!parent;
}

class DzlGraphModelClass is repr<CStruct> is export {
	has GObjectClass $!parent;
}

class DzlGraphModelIter is repr<CStruct> is export {
	has gpointer $!data;
}

class DzlGraphViewClass is repr<CStruct> is export {
	has GtkDrawingAreaClass $!parent_class;
	has gpointer            $!_reserved1  ;
	has gpointer            $!_reserved2  ;
	has gpointer            $!_reserved3  ;
	has gpointer            $!_reserved4  ;
	has gpointer            $!_reserved5  ;
	has gpointer            $!_reserved6  ;
	has gpointer            $!_reserved7  ;
	has gpointer            $!_reserved8  ;
}

class DzlListBoxClass is repr<CStruct> is export {
	has GtkListBoxClass $!parent_class;
	has gpointer        $!_reserved   ;
}

class DzlListBoxRowClass is repr<CStruct> is export {
	has GtkListBoxRowClass $!parent_class;
}

class DzlListStoreAdapterClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class DzlMenuButtonClass is repr<CStruct> is export {
	has GtkMenuButtonClass $!parent_class;
	has gpointer           $!_reserved1  ;
	has gpointer           $!_reserved2  ;
	has gpointer           $!_reserved3  ;
	has gpointer           $!_reserved4  ;
}

class DzlPreferencesEntryClass is repr<CStruct> is export {
	has DzlPreferencesBinClass $!parent_class;
}

class DzlPreferencesViewClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
	has gpointer    $!_reserved   ;
}

class DzlPriorityBoxClass is repr<CStruct> is export {
	has GtkBoxClass $!parent_class;
	has gpointer    $!_reserved1  ;
	has gpointer    $!_reserved2  ;
	has gpointer    $!_reserved3  ;
	has gpointer    $!_reserved4  ;
}

class DzlProgressButtonClass is repr<CStruct> is export {
	has GtkButtonClass $!parent_class;
	has gpointer       $!_reserved1  ;
	has gpointer       $!_reserved2  ;
	has gpointer       $!_reserved3  ;
	has gpointer       $!_reserved4  ;
}

class DzlProgressMenuButtonClass is repr<CStruct> is export {
	has GtkMenuButtonClass $!parent_class;
	has gpointer           $!_reserved1  ;
	has gpointer           $!_reserved2  ;
	has gpointer           $!_reserved3  ;
	has gpointer           $!_reserved4  ;
}

class DzlRadioBoxClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
	has gpointer    $!_padding1   ;
	has gpointer    $!_padding2   ;
	has gpointer    $!_padding3   ;
	has gpointer    $!_padding4   ;
}

class DzlShortcutManagerClass is repr<CStruct> is export {
	has GObjectClass $!parent_instance;
	has gpointer     $!_reserved1     ;
	has gpointer     $!_reserved2     ;
	has gpointer     $!_reserved3     ;
	has gpointer     $!_reserved4     ;
	has gpointer     $!_reserved5     ;
	has gpointer     $!_reserved6     ;
	has gpointer     $!_reserved7     ;
	has gpointer     $!_reserved8     ;
}

class DzlShortcutThemeClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
	has gpointer     $!_reserved1  ;
	has gpointer     $!_reserved2  ;
	has gpointer     $!_reserved3  ;
	has gpointer     $!_reserved4  ;
	has gpointer     $!_reserved5  ;
	has gpointer     $!_reserved6  ;
	has gpointer     $!_reserved7  ;
	has gpointer     $!_reserved8  ;
}

class DzlShortcutThemeEditorClass is repr<CStruct> is export {
	has GtkBinClass $!parent_class;
	has gpointer    $!_reserved1  ;
	has gpointer    $!_reserved2  ;
	has gpointer    $!_reserved3  ;
	has gpointer    $!_reserved4  ;
	has gpointer    $!_reserved5  ;
	has gpointer    $!_reserved6  ;
	has gpointer    $!_reserved7  ;
	has gpointer    $!_reserved8  ;
}

class DzlSliderClass is repr<CStruct> is export {
	has GtkContainerClass $!parent_instance;
}

class DzlStateMachineClass is repr<CStruct> is export {
	has GObjectClass $!parent;
}

class DzlSuggestionButtonClass is repr<CStruct> is export {
	has GtkStackClass $!parent_class;
	has gpointer      $!_reserved   ;
}

class DzlSuggestionEntryBufferClass is repr<CStruct> is export {
	has GtkEntryBufferClass $!parent_class;
	has gpointer            $!_reserved1  ;
	has gpointer            $!_reserved2  ;
	has gpointer            $!_reserved3  ;
	has gpointer            $!_reserved4  ;
}

class DzlSuggestionRowClass is repr<CStruct> is export {
	has DzlListBoxRowClass $!parent_class;
	has gpointer           $!_reserved   ;
}

class DzlTabStripClass is repr<CStruct> is export {
	has GtkBoxClass $!parent    ;
	has gpointer    $!_reserved1;
	has gpointer    $!_reserved2;
	has gpointer    $!_reserved3;
	has gpointer    $!_reserved4;
	has gpointer    $!_reserved5;
	has gpointer    $!_reserved6;
	has gpointer    $!_reserved7;
	has gpointer    $!_reserved8;
}

class DzlThreeGridClass is repr<CStruct> is export {
	has GtkContainerClass $!parent_class;
	has gpointer          $!_reserved1  ;
	has gpointer          $!_reserved2  ;
	has gpointer          $!_reserved3  ;
	has gpointer          $!_reserved4  ;
	has gpointer          $!_reserved5  ;
	has gpointer          $!_reserved6  ;
	has gpointer          $!_reserved7  ;
	has gpointer          $!_reserved8  ;
}

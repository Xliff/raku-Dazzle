use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use Dazzle::Raw::Types;

role Dazzle::Roles::Signals::Tree::Builder {
  has %!signals-dtb;

  #  DzlTreeNode *node --> void
   method connect-node (
     $obj,
     $signal,
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-node($obj, $signal,
         -> $, $dtn {
           CATCH {
             default { 𝒮.note($_) }
           }

           𝒮.emit( [self, $dtn] );
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  DzlTreeNode *node, GtkSelectionData *data --> gboolean
   method connect-node-select (
     $obj,
     $signal,
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-node-select($obj, $signal,
         -> $, $dtn, $gsd {
           CATCH {
             default { 𝒮.note($_) }
           }

           my $r = ReturnedValue.new;
           𝒮.emit( [self, $dtn, $gsd, $r] );
           $r.r;
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  DzlTreeNode *drag_node, DzlTreeNode *drop_node, DzlTreeDropPosition position, GdkDragAction action, GtkSelectionData *data --> gboolean
   method connect-drag-node-received (
     $obj,
     $signal = 'drag-node-received',
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-drag-node-received($obj, $signal,
         -> $, $dtn1, $dtn2, $dtdp, $gda, $gsd {
           CATCH {
             default { 𝒮.note($_) }
           }

           my $r = ReturnedValue.new;
           𝒮.emit( [self, $dtn1, $dtn2, $dtdp, $gda, $gsd, $r] );
           $r.r;
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  DzlTreeNode *node --> gboolean
   method connect-node-rbool (
     $obj,
     $signal,
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-node-rbool($obj, $signal,
         -> $, $dtn {
           CATCH {
             default { 𝒮.note($_) }
           }

           my $r = ReturnedValue.new;
           𝒮.emit( [self, $dtn, $r] );
           $r.r;
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  GtkWidget *tree --> void
   method connect-tree-widget (
     $obj,
     $signal,
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-tree-widget($obj, $signal,
         -> $, $gw {
           CATCH {
             default { 𝒮.note($_) }
           }

           𝒮.emit( [self, $gw] );
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  DzlTreeNode *drop_node, DzlTreeDropPosition position, GdkDragAction action, GtkSelectionData *data --> gboolean
   method connect-drag-data-received (
     $obj,
     $signal = 'drag-data-received',
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-drag-data-received($obj, $signal,
         -> $, $dtn, $dtdp, $gda, $gsd {
           CATCH {
             default { 𝒮.note($_) }
           }

           my $r = ReturnedValue.new;
           𝒮.emit( [self, $dtn, $dtdp, $gda, $gsd, $r] );
           $r.r;
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

   #  DzlTreeNode *node, GMenu *menu --> void
   method connect-node-popup (
     $obj,
     $signal = 'node-popup',
     &handler?
   ) {
     my $hid;
     %!signals-dtb{$signal} //= do {
       my \𝒮 = Supplier.new;
       $hid = g-connect-node-popup($obj, $signal,
         -> $, $dtn, $ {
           CATCH {
             default { 𝒮.note($_) }
           }

           my $r = ReturnedValue.new;
           𝒮.emit( [self, $dtn, $, $r] );
           $r.r;
         },
         Pointer, 0
       );
       [ 𝒮.Supply, $obj, $hid ];
     };
     %!signals-dtb{$signal}[0].tap(&handler) with &handler;
     %!signals-dtb{$signal}[0];
   }

}

# DzlTreeBuilder *builder, DzlTreeNode *node
sub g-connect-node (
  Pointer $app,
  Str     $name,
          &handler (DzlTreeBuilder, DzlTreeNode),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, DzlTreeNode *node, GtkSelectionData *data --> gboolean
sub g-connect-node-select (
  Pointer $app,
  Str     $name,
          &handler (DzlTreeBuilder, DzlTreeNode, GtkSelectionData --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, DzlTreeNode *drag_node, DzlTreeNode *drop_node, DzlTreeDropPosition position, GdkDragAction action, GtkSelectionData *data --> gboolean
sub g-connect-drag-node-received (
  Pointer $app,
  Str     $name,
          &handler (
            DzlTreeBuilder,
            DzlTreeNode,
            DzlTreeNode,
            DzlTreeDropPosition,
            GdkDragAction,
            GtkSelectionData
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, DzlTreeNode *node --> gboolean
sub g-connect-node-rbool (
  Pointer $app,
  Str     $name,
          &handler (DzlTreeBuilder, DzlTreeNode --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, GtkWidget *tree
sub g-connect-tree-widget (
  Pointer $app,
  Str     $name,
          &handler (DzlTreeBuilder, GtkWidget),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, DzlTreeNode *drop_node, DzlTreeDropPosition position, GdkDragAction action, GtkSelectionData *data --> gboolean
sub g-connect-drag-data-received (
  Pointer $app,
  Str     $name,
          &handler (
            DzlTreeBuilder,
            DzlTreeNode,
            DzlTreeDropPosition,
            GdkDragAction,
            GtkSelectionData
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# DzlTreeBuilder *builder, DzlTreeNode *node, GMenu *menu
sub g-connect-node-popup (
  Pointer $app,
  Str     $name,
          &handler (DzlTreeBuilder, DzlTreeNode, GMenu),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

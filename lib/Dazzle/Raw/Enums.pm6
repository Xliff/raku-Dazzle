use v6.c;

use GLib::Raw::Definitions;
use Dazzle::Raw::Definitions;

unit package Dazzle::Raw::Enums;

constant DzlDockRevealerTransitionType is export := guint32;
our enum DzlDockRevealerTransitionTypeEnum is export <
  DZL_DOCK_REVEALER_TRANSITION_TYPE_NONE
  DZL_DOCK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
  DZL_DOCK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
  DZL_DOCK_REVEALER_TRANSITION_TYPE_SLIDE_UP
  DZL_DOCK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
>;

constant DzlFileTransferFlags is export := guint32;
our enum DzlFileTransferFlagsEnum is export (
  DZL_FILE_TRANSFER_FLAGS_NONE =>      0,
  DZL_FILE_TRANSFER_FLAGS_MOVE => 1 +< 0,
);

constant DzlPropertiesFlags is export := guint32;
our enum DzlPropertiesFlagsEnum is export (
  'DZL_PROPERTIES_FLAGS_NONE',
  DZL_PROPERTIES_FLAGS_STATEFUL_BOOLEANS => 1 +< 0,
);

constant DzlShortcutMatch is export := guint32;
our enum DzlShortcutMatchEnum is export <
  DZL_SHORTCUT_MATCH_NONE
  DZL_SHORTCUT_MATCH_EQUAL
  DZL_SHORTCUT_MATCH_PARTIAL
>;

constant DzlShortcutNodeType is export := guint32;
our enum DzlShortcutNodeTypeEnum is export (
  'DZL_SHORTCUT_NODE_GROUP',
  DZL_SHORTCUT_NODE_SECTION => 1,
  'DZL_SHORTCUT_NODE_ACTION',
  'DZL_SHORTCUT_NODE_COMMAND'
);

constant DzlShortcutPhase is export := guint32;
our enum DzlShortcutPhaseEnum is export (
  DZL_SHORTCUT_PHASE_DISPATCH =>      0,
  DZL_SHORTCUT_PHASE_CAPTURE  => 1 +< 0,
  DZL_SHORTCUT_PHASE_BUBBLE   => 1 +< 1,
  DZL_SHORTCUT_PHASE_GLOBAL   => 1 +< 2,
);

constant DzlShortcutType is export := guint32;
our enum DzlShortcutTypeEnum is export <
  DZL_SHORTCUT_ACCELERATOR
  DZL_SHORTCUT_GESTURE_PINCH
  DZL_SHORTCUT_GESTURE_STRETCH
  DZL_SHORTCUT_GESTURE_ROTATE_CLOCKWISE
  DZL_SHORTCUT_GESTURE_ROTATE_COUNTERCLOCKWISE
  DZL_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_LEFT
  DZL_SHORTCUT_GESTURE_TWO_FINGER_SWIPE_RIGHT
  DZL_SHORTCUT_GESTURE
>;

constant DzlSliderPosition is export := guint32;
our enum DzlSliderPositionEnum is export <
  DZL_SLIDER_NONE
  DZL_SLIDER_TOP
  DZL_SLIDER_RIGHT
  DZL_SLIDER_BOTTOM
  DZL_SLIDER_LEFT
>;

constant DzlThreeGridColumn is export := guint32;
our enum DzlThreeGridColumnEnum is export <
  DZL_THREE_GRID_COLUMN_LEFT
  DZL_THREE_GRID_COLUMN_CENTER
  DZL_THREE_GRID_COLUMN_RIGHT
>;

constant DzlTitlebarAnimation is export := guint32;
our enum DzlTitlebarAnimationEnum is export (
  DZL_TITLEBAR_ANIMATION_HIDDEN  => 0,
  DZL_TITLEBAR_ANIMATION_SHOWING => 1,
  DZL_TITLEBAR_ANIMATION_SHOWN   => 2,
  DZL_TITLEBAR_ANIMATION_HIDING  => 3,
);

constant DzlTreeDropPosition is export := guint32;
our enum DzlTreeDropPositionEnum is export (
  DZL_TREE_DROP_INTO   => 0,
  DZL_TREE_DROP_BEFORE => 1,
  DZL_TREE_DROP_AFTER  => 2,
);

constant Dzlanimationmode is export := guint32;
our enum DzlanimationmodeEnum is export <
  DZL_ANIMATION_LINEAR
  DZL_ANIMATION_EASE_IN_QUAD
  DZL_ANIMATION_EASE_OUT_QUAD
  DZL_ANIMATION_EASE_IN_OUT_QUAD
  DZL_ANIMATION_EASE_IN_CUBIC
  DZL_ANIMATION_EASE_OUT_CUBIC
  DZL_ANIMATION_EASE_IN_OUT_CUBIC
  DZL_ANIMATION_LAST
>;

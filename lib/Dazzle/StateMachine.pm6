use v6.c;

use GLib::Raw::Traits;
use Dazzle::Raw::Types;
use Dazzle::Raw::StateMachine;

use GLib::Value;

use GLib::Roles::Object;

our subset DzlStateMachineAncestry is export of Mu
  when DzlStateMachine | GObject;

my %transitions;

class Dazzle::StateMachine {
  also does GLib::Roles::Object;

  has DzlStateMachine $!dsm is implementor;

  submethod BUILD (:$dzl-state-machine) {
    self.setDzlStateMachine($dzl-state-machine) if $dzl-state-machine;
  }

  method setDzlStateMachine (DzlStateMachineAncestry $_) {
    my $to-parent;

    $!dsm = do {
      when DzlStateMachine {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(DzlStateMachine, $_);
      }
    }
    self!setObject($to-parent);
  }

  method Dazzle::Raw::Definitions::DzlStateMachine
  { $!dsm }

  multi method new (DzlStateMachineAncestry $dzl-state-machine, :$ref = True) {
    return Nil unless $dzl-state-machine;

    my $o = self.bless( :$dzl-state-machine );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $dzl-state-machine = dzl_state_machine_new();

    $dzl-state-machine ?? self.bless( :$dzl-state-machine ) !! Nil;
  }

  # Type: string
  method state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('state', $gv);
      }
    );
  }

  method add_binding (
    Str()         $state,
    gpointer      $source_object,
    Str()         $source_property,
    gpointer      $target_object,
    Str()         $target_property,
    Int()         $flags
  ) {
    my GBindingFlags $f = $flags;

    dzl_state_machine_add_binding(
      $!dsm,
      $state,
      $source_object,
      $source_property,
      $target_object,
      $target_property,
      $flags
    );
  }

  method add_propertyv (
    Str()    $state,
    gpointer $object,
    Str()    $property,
    GValue() $value
  ) {
    dzl_state_machine_add_propertyv($!dsm, $state, $object, $property, $value);
  }

  method add_style (Str() $state, GtkWidget() $widget, Str() $style) {
    dzl_state_machine_add_style($!dsm, $state, $widget, $style);
  }

  method connect_object (
    Str()         $state,
    gpointer      $source,
    Str()         $detailed_signal,
                  &callback,
    gpointer      $user_data        = gpointer,
    Int()         $flags            = 0
  ) {
    my GConnectFlags $f = $flags;

    dzl_state_machine_connect_object(
      $!dsm,
      $state,
      $source,
      $detailed_signal,
      &callback,
      $user_data,
      $f
    );
  }

  method create_action (Str() $name) {
    dzl_state_machine_create_action($!dsm, $name);
  }

  method get_state {
    dzl_state_machine_get_state($!dsm);
  }

  method is_state (Str() $state) {
    so dzl_state_machine_is_state($!dsm, $state);
  }

  method set_state (Str() $state) {
    dzl_state_machine_set_state($!dsm, $state);
  }

  method transition-on-click (
    GObject()  $object,
               $origin-state,
               $new-state,
              :$closure        = Callable,
              :$condition      = Callable
  ) {
    self.transition(
       $object,
       'clicked',
       $origin-state,
       $new-state,
      :$closure,
      :$condition
    );
  }

  method transition-on-select (
    GObject()  $object,
               $origin-state,
               $new-state,
              :$closure        = Callable,
              :$condition      = Callable
  ) {
    self.transition(
       $object,
       'selected',
       $origin-state,
       $new-state,
      :$closure,
      :$condition
    );
  }

  method transition-on-activate (
    GObject()  $object,
               $origin-state,
               $new-state,
              :$closure        = Callable,
              :$condition      = Callable
  ) {
    self.transition(
       $object,
       'activated',
       $origin-state,
       $new-state,
      :$closure,
      :$condition
    );
  }

  # cw: QoL improvements:
  method transition (
    GObject()  $object,
               $signal,
               $origin-state,
               $new-state,
              :$closure        = Callable,
              :$condition      = Callable
  ) {
    X::StateMachine::TransitionActionNotFound.new(
      name   => $object.name,
      signal => $signal
    ).new.throw unless $object.^can($signal);

    my \t := %transitions{ +$!dsm }{ +$object }{$origin-state}{$new-state};

    return if t;
    
    t = 1;

    my $machine = self;
    $object."$signal"().tap( sub (*@a) {
      return unless $machine.state eq $origin-state;

      if $condition {
        return unless $condition();
      }

      $machine.state =  $new-state;
      $closure()     if $closure;
    });
  }

}

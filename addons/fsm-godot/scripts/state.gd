@icon("res://addons/fsm-godot/icons/state.png")
extends Node
class_name State

# PRIVATE VARIABLES

# The Finite State Machine that this State is a part of. The FSM is always a parent of the State
@onready var _fsm : FiniteStateMachine = get_parent() as FiniteStateMachine

## The interval at which the transitions are checked
@export var _check_transition_interval : float = 1

# map of transition trigger event names to transitions.
var _transitions : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Transition and child.transition_event_name != null:
			_transitions[child.transition_event_name] = child

func transitionRequested(transitionEventName):
	if (_transitions.has(transitionEventName)):
		var transition = _transitions[transitionEventName]
		_fsm.change_state(transition.target_state)

## Called when the node enters the scene tree for the first time.
func enter_state() -> void:
	pass


## Called when the node is about to be removed from the scene tree.
func exit_state() -> void:
	pass
	

## Called every frame
func update(_delta : float) -> void:
	pass

## Called every physics frame
func physics_update(_delta : float) -> void:
	pass
	

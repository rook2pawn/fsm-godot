@icon("res://addons/fsm-godot/icons/fsm.png")
extends Node
class_name FiniteStateMachine

signal transitionEvent(transitionEventName: String)

## Initial State that the State Machine will start with
@export var _initial_state : State

# PRIVATE VARIABLES

@export var _current_state : State

## The states  that are a part of this fsm 
var _states : Array[State]

# proxies emits to external agents
func emit(transitionEventName):
	transitionEvent.emit(transitionEventName)
	# query if current state has 

func onTransitionEvent(transitionEventName):
	for state in _states:
		state.transitionRequested(transitionEventName)
		

func _ready():
	for child in get_children():
		if child is State:
			_states.append(child)

	transitionEvent.connect(onTransitionEvent)
	if _initial_state:
		change_state(_initial_state)

func _process(delta):
	if _current_state:
		_current_state.update(delta)


func _physics_process(delta):
	if _current_state:
		_current_state.physics_update(delta)


## Change the current state of the State Machine
func change_state(new_state: State):
	if (_current_state == new_state) :
		return
	if _current_state is State:
		# Exit the current state and enter the new one
		_current_state.exit_state()
	new_state.enter_state()
	# Set the new state as the current one
	_current_state = new_state


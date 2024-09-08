@icon("res://addons/fsm-godot/icons/fsm.png")
extends Node
class_name FiniteStateMachine

## Initial State that the State Machine will start with
@export var _initial_state : State

# PRIVATE VARIABLES

@export var _current_state : State

## The states  that are a part of this fsm 
var _states : Array[State]

# proxies emits to external agents
func emit(transitionEventName: String):
	_current_state.transitionRequested(transitionEventName)

# Generalized function to connect any signal
func connect_ready_signal(sig : Signal):
	sig.connect(on_ready_signal_received)

# Example callback for the ready signal
func on_ready_signal_received():
	printt("FSM: ON READY SIGNAL RECEIVED")
	if _initial_state:
		change_state(_initial_state)
		
func _ready():
	# populate states
	for child in get_children():
		if child is State:
			_states.append(child)
	printt("FSM READY")

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
	#printt("SETTING _CURRENT_STATE TO NEW STATE:", _current_state, new_state)
	# Set the new state as the current one
	_current_state = new_state

@icon("res://addons/fsm-godot/icons/transition.png")
extends Node
class_name Transition

@export var target_state : State
@export var transition_event_name : String = ""

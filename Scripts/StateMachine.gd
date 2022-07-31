extends Node
class_name StateMachine

var _state : State
var State : State setget set_state, get_state

func set_state(value):
	_state = states[value]

func get_state():
	return _state
	
var states = {}

func add_state(state):
	states[state.Name] = state

func update(delta):
	pass

func animate(delta):
	pass

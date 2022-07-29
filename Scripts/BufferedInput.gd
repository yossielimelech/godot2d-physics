extends Node
class_name BufferedInput

var Pressed : bool setget ,get_pressed
var Holds : bool setget ,get_holds

var _binding : String
var _buffer : float = 0.1
var _hold : float = 0.3
var _current_buffer : float = 0
var _current_hold : float = 0

func get_pressed():
	return _current_buffer > 0

func get_holds():
	return _current_hold > 0

func _init(binding: String, buffer: float = 0.1, hold: float = 0.2):
	_binding = binding
	_buffer = buffer
	_hold = hold
	
func _process(delta):
	_current_buffer -= delta
	_current_hold -= delta
	if Input.is_action_just_pressed(_binding):
		_current_buffer = _buffer
		
	if _current_hold > 0 && !Input.is_action_pressed(_binding):
		_current_hold = 0

func Consume():
	_current_hold = _hold
	_current_buffer = 0

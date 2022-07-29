extends Node


var Jump = BufferedInput.new("Jump", 0.1, 0.2) setget ,get_jump
var Attack = BufferedInput.new("Attack", 0.1, 0) setget ,get_attack

var _inputs : Array = [Jump, Attack]

func get_jump():
	return Jump

func get_attack():
	return Attack

func _process(delta):
	for input in _inputs:
		input._process(delta)

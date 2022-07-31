extends Node
class_name State

var _name : String
var _parent : Object
var _machine

var Name : String setget ,get_name

func get_name():
	return _name

func _init(name: String, parent: Object, machine):
	_name = name
	_parent = parent
	_machine = machine

func can_enter():
	pass

func on_enter():
	pass
	
func on_exit():
	pass
	
func update(delta):
	pass

func animate(delta):
	pass

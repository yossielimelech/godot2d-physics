extends Node
class_name State

var _name : String
var _parent : Object
var _machine
var _stamina : int

var Name : String setget ,get_name

func get_name():
	return _name

func _init(name: String, parent: Object, machine, stamina: int = 0):
	_name = name
	_parent = parent
	_machine = machine
	_stamina = stamina

func can_enter():
	if _parent.stamina >= _stamina:
		return true
	else:
		_parent.emit_signal("on_not_enough_stamina")
	pass

func on_enter():
	if _stamina > 0:
		_parent.consume_stamina(_stamina)
	pass
	
func on_exit():
	pass
	
func update(delta):
	pass

func animate(delta):
	pass

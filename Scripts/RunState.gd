extends "res://Scripts/State.gd"
class_name RunState

func on_enter():
	pass

func on_exit():
	pass

func _init(name: String, parent: Object, machine, stamina : int).(name, parent, machine, stamina):
	pass

func can_enter():
	if !.can_enter():
		return false
	return _parent.direction != 0 && [_machine.Idle, _machine.Run].has(_machine.State)

func update(delta):
	if _parent.direction == 0 && _parent.velocity.x == 0:
		return _machine.Idle
	if !_parent.on_ground:
		return _machine.Dropped

func animate(delta):
	_parent.PlayUniqueAnimation("Run")

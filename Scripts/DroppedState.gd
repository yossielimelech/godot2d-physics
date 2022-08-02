extends "res://Scripts/State.gd"
class_name DroppedState

func on_enter():
	pass
	
func on_exit():
	pass

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass

func can_enter():
	return false

func update(delta):
	if _parent.on_ground:
		_parent.consume_health(15)
		if _parent.get_direction() != 0:
			return _machine.Run
		else:
			return _machine.Idle


func animate(delta):
	_parent.PlayUniqueAnimation("Fall")

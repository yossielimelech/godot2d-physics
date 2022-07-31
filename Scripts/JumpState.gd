extends "res://Scripts/State.gd"
class_name JumpState

func on_enter():
	InputManager.Jump.Consume()
	_parent.velocity.y = _parent.jump_force

func on_exit():
	pass

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass


func can_enter():
	if _machine.State == _machine.Jump || [_machine.Idle, _machine.Run].has(_machine.State) && InputManager.Jump.Pressed && (_parent.on_ground || _parent.local_cayote_time > 0):
		return true

func update(delta):
	if !_parent.on_ground && InputManager.Jump.Holds:
		_parent.velocity.y = _parent.jump_force
	
	if _parent.on_ground:
		if _parent.get_direction() != 0:
			return _machine.Run
		else:
			return _machine.Idle
	
func animate(delta):
	if _parent.velocity.y < 0:
		_parent.PlayUniqueAnimation("Jump")
	else:
		_parent.PlayUniqueAnimation("Fall")

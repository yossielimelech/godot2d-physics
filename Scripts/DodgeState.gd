extends "res://Scripts/State.gd"
class_name DodgeState

var buffered_attack : bool
var start_y_position : int

func on_enter():
	.on_enter()
	InputManager.Roll.Consume()
	_parent.velocity.x = -_parent.face * _parent.dodge_force
	_parent.velocity.y = _parent.jump_force
	start_y_position = _parent.global_position.y

func on_exit():
	buffered_attack = false

func _init(name: String, parent: Object, machine, stamina : int).(name, parent, machine, stamina):
	pass


func can_enter():
	if !.can_enter():
		return false
	if _machine.State == _machine.Dodge || [_machine.Idle].has(_machine.State) && InputManager.Roll.Pressed && (_parent.on_ground || _parent.local_cayote_time > 0):
		return true

func update(delta):
	buffered_attack = buffered_attack || InputManager.Attack.Pressed
	
	if _parent.on_ground:
		if buffered_attack:
			return _machine.Attack
		elif _parent.get_direction() != 0:
			return _machine.Run
		else:
			return _machine.Idle
	
	if _parent.global_position.y > start_y_position:
		return _machine.Dropped


	
func animate(delta):
	if _parent.velocity.y <= 0:
		_parent.PlayUniqueAnimation("Jump")
	else:
		_parent.PlayUniqueAnimation("Fall")

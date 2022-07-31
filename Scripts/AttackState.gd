extends "res://Scripts/State.gd"
class_name AttackState

func on_enter():
	InputManager.Attack.Consume()

func on_exit():
	pass

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass

func can_enter():
	if [_machine.Run, _machine.Idle, _machine.Attack].has(_machine.State):
		return InputManager.Attack.Pressed


func update(delta):
	if !_parent.AttackAnimationEnded():
		_parent.direction = 0
	else:
		return _machine.Idle

func animate(delta):
	_parent.PlayAttackAnimation()

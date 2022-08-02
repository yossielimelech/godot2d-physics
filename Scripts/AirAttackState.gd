extends "res://Scripts/State.gd"
class_name AirAttackState

func on_enter():
	.on_enter()
	InputManager.Attack.Consume()

func on_exit():
	pass

func _init(name: String, parent: Object, machine, stamina : int = 0).(name, parent, machine, stamina):
	pass

func can_enter():
	if !.can_enter():
		return false
	if _machine.State == _machine.AirAttack || [_machine.Jump].has(_machine.State) && InputManager.Attack.Pressed:
		return true

func update(delta):
	if _parent.AnimationEnded("AirAttack"):
		return _machine.Dropped

func animate(delta):
	_parent.PlayUniqueAnimation("AirAttack")

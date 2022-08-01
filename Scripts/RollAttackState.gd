extends "res://Scripts/State.gd"
class_name RollAttackState

func on_enter():
	InputManager.Attack.Consume()

func on_exit():
	pass

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass

func can_enter():
	pass

func update(delta):
	_parent.direction = 0
	
	if _parent.AnimationEnded("Attack3"):
		return _machine.Idle

func animate(delta):
	_parent.PlayUniqueAnimation("Attack3")

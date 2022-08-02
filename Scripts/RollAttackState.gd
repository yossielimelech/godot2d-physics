extends "res://Scripts/State.gd"
class_name RollAttackState

func on_enter():
	.on_enter()
	InputManager.Attack.Consume()

func on_exit():
	pass

func _init(name: String, parent: Object, machine, stamina : int).(name, parent, machine, stamina):
	pass

func can_enter():
	if !.can_enter():
		return false
	if _machine.State == _machine.Roll && InputManager.Attack.Pressed:
		return true

func update(delta):
	
	_parent.direction = 0
	
	if _parent.AnimationEnded("Attack3"):
		return _machine.Idle

func animate(delta):
	_parent.PlayUniqueAnimation("Attack3")

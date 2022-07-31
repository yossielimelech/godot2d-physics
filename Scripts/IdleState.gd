extends "res://Scripts/State.gd"
class_name IdleState

func on_enter():
	pass

func on_exit():
	pass

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass
	
func can_enter():
	return ![_machine.Attack, _machine.AirAttack, _machine.Jump, _machine.Run].has(_machine.State)

func update(delta):
	pass
	

func animate(delta):
	_parent.PlayUniqueAnimation("Idle")

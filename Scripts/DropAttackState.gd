extends "res://Scripts/State.gd"
class_name DropAttackState

var start_y_position : int
var attack : bool

func on_enter():
	.on_enter()
	start_y_position = _parent.global_position.y

func on_exit():
	attack = false
	
func _init(name: String, parent: Object, machine, stamina : int = 0).(name, parent, machine, stamina):
	pass

func can_enter():
	if !.can_enter():
		return false
	return _machine.State == _machine.Dropped && InputManager.Attack.Pressed && !_parent.drop_attack_rays_colliding()

func update(delta):
	_parent.velocity.x = 0
	if _parent.global_position.y - start_y_position  >= 16:
		attack = true
	if _parent.AnimationEnded("DropAttackEnd"):
		return _machine.Idle

func animate(delta):
	if attack && _parent.on_ground:
		_parent.PlayUniqueAnimation("DropAttackEnd")
	elif attack:
		_parent.PlayUniqueAnimation("DropAttack")
	else:
		_parent.PlayUniqueAnimation("Fall")
		

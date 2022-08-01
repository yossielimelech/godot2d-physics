extends "res://Scripts/State.gd"
class_name RollState

var buffered_attack : bool

func on_enter():
	InputManager.Roll.Consume()
	_parent.velocity.x = _parent.face * _parent.roll_force
	_parent.hitbox = _parent.roll_hitbox
	_parent.animated_sprite.offset.y = 5


func on_exit():
	_parent.hitbox = _parent.normal_hitbox
	_parent.animated_sprite.offset.y = 0
	buffered_attack = false

func _init(name: String, parent: Object, machine).(name, parent, machine):
	pass


func can_enter():
	if _machine.State == _machine.Roll || [_machine.Run].has(_machine.State) && InputManager.Roll.Pressed && (_parent.on_ground || _parent.local_cayote_time > 0):
		return true

func update(delta):
	buffered_attack = buffered_attack || InputManager.Attack.Pressed

	if _parent.AnimationEnded("Roll"):
		if _parent.on_ground:
			if buffered_attack:
				return _machine.RollAttack
			elif _parent.direction != 0:
				return _machine.Run
			else:
				return _machine.Idle
		else:
			return _machine.Dropped
	
	
func animate(delta):
	_parent.PlayUniqueAnimation("Roll")

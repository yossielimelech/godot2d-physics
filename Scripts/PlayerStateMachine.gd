extends "res://Scripts/StateMachine.gd"

class_name PlayerStateMachine
onready var _parent = get_parent()

onready var Attack = AttackState.new("Attack", _parent, self)
onready var AirAttack = AirAttackState.new("AirAttack", _parent, self)
onready var Jump = JumpState.new("Jump", _parent, self)
onready var Run = RunState.new("Run", _parent, self)
onready var Dropped = DroppedState.new("Dropped", _parent, self)
onready var Idle = IdleState.new("Idle", _parent, self)


func _ready():
	add_state(Attack)
	add_state(AirAttack)
	add_state(Jump)
	add_state(Run)
	add_state(Dropped)
	add_state(Idle)
	
	set_state("Idle")
	

func update(delta):
	if _state != null:
		var new_state = _state.update(delta)
		if new_state != null:
			_state.on_exit()
			_state = new_state
		else:
			for curr_state in states:
				if states[curr_state].can_enter():
					if _state != states[curr_state]:
						_state = states[curr_state]
						_state.on_enter()

func animate(delta):
	if _state != null:
		_state.animate(delta)

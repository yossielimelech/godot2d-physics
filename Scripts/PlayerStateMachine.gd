extends "res://Scripts/StateMachine.gd"

class_name PlayerStateMachine
onready var _parent = get_parent()

onready var Attack = AttackState.new("Attack", _parent, self, 25)
onready var AirAttack = AirAttackState.new("AirAttack", _parent, self, 25)
onready var RollAttack = RollAttackState.new("RollAttack", _parent, self, 25)
onready var Dodge = DodgeState.new("Dodge", _parent, self, 10)
onready var Roll = RollState.new("Roll", _parent, self, 10)
onready var Jump = JumpState.new("Jump", _parent, self, 5)
onready var Run = RunState.new("Run", _parent, self, 0)
onready var DropAttack = DropAttackState.new("DropAttack", _parent, self, 25)
onready var Dropped = DroppedState.new("Dropped", _parent, self)
onready var Idle = IdleState.new("Idle", _parent, self)


func _ready():
	add_state(Attack)
	add_state(AirAttack)
	add_state(RollAttack)
	add_state(Dodge)
	add_state(Roll)
	add_state(Jump)
	add_state(Run)
	add_state(DropAttack)
	add_state(Dropped)
	add_state(Idle)
	
	set_state("Idle")
	

func update(delta):
	if _state != null:
		var new_state = _state.update(delta)
		if new_state != null:
			_state.on_exit()
			_state = new_state
			_state.on_enter()
		else:
			for curr_state in states:
				if states[curr_state].can_enter():
					if _state != states[curr_state]:
						_state.on_exit()
						_state = states[curr_state]
						_state.on_enter()

func animate(delta):
	if _state != null:
		_state.animate(delta)

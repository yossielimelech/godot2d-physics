extends Node
class_name GameResource

signal on_not_enough_resource
signal on_max_resource_update
signal on_resource_update

export var resource_name = ''
export var max_value = 100
export var regen_per_second = 60
export var pause_regen_time = 0.8
onready var value = max_value

var local_pause_regen_time = 0

func _ready():
	emit_signal("on_max_resource_update", max_value, (value / max_value) * 100)
	emit_signal("on_resource_update", value, 0, 0)
	
func _physics_process(delta):
	if(local_pause_regen_time < 0):
		update(-delta * regen_per_second)
	
	local_pause_regen_time -= delta

func can_consume(amount):
	return amount <= value

func update(amount):
	if amount > 0:
		local_pause_regen_time = pause_regen_time
		if value < amount:
			emit_signal("on_not_enough_resource")
	value -= amount
	value = clamp(value, 0, max_value)
	emit_signal("on_resource_update", (value / max_value) * 100, amount, pause_regen_time)

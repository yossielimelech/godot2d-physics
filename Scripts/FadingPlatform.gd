extends "res://Scripts/Solid.gd"

onready var tween = $Tween

export var on_time : float = 1
export var off_time : float = 3
var fall_thru = false

func _ready():
	init_tween()

func init_tween():
	tween.interpolate_property(self, "fall_thru", false, true, on_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.interpolate_property(self, "fall_thru", true, false, off_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, on_time)
	tween.repeat = true
	tween.connect("tween_step", self, "on_tween_step")
	tween.start()

func on_tween_step(object, key, elapsed, value):
	hitbox.collidable = !fall_thru
	

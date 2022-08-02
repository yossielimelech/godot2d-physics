extends Control

onready var FGbar = $FG
onready var BGbar = $BG
onready var tween = $RechargeTween
onready var blink_tween = $BlinkTween

func _on_value_update(value, amount, recharge_time):
	FGbar.value = value
	if(BGbar.value > value):
		tween.interpolate_property(BGbar, "value", BGbar.value, value, recharge_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
	else:
		BGbar.value = value

func _on_max_value_update(value):
	FGbar.max_value = value
	BGbar.max_value = value


func _on_not_enough_resource():
	pass

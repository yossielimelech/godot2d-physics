extends Control
export var size_per_resource = 1
export var FGTheme : Theme = Theme.new()
export var BGTheme : Theme = Theme.new()

onready var FGbar = $FG
onready var BGbar = $BG
onready var tween = $RechargeTween
onready var blink_tween = $BlinkTween


func _ready():
	FGbar.theme = FGTheme
	BGbar.theme = BGTheme

func _on_value_update(value, amount, charge_time):
	FGbar.value = value
	if(BGbar.value > value):
		tween.interpolate_property(BGbar, "value", BGbar.value, value, charge_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
	else:
		BGbar.value = value

func _on_max_value_update(max_value, value):
	var rect = get_rect()
	FGbar.rect_size = Vector2(size_per_resource * max_value, rect.size.y)
	BGbar.rect_size = Vector2(size_per_resource * max_value, rect.size.y)
	FGbar.value = value
	BGbar.value = value


func _on_not_enough_resource():
	pass

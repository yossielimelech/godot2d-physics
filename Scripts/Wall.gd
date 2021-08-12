extends Node2D

export var jump_thru = false
onready var hitbox = $Hitbox

func _ready():
	add_to_group("Walls")

tool
extends Node2D

export var x = 0
export var y = 0
export var width = 16
export var height = 16
export var color = Color(0,0,1,0.5)
export var disable_color = Color(0.8, 0.8, 0.8, 0.5)

onready var original_color = color

var m_collidable = true
var collidable setget set_collidable, get_collidable
var left setget ,get_left
var right setget ,get_right
var top setget ,get_top
var bottom setget ,get_bottom

func set_collidable(value):
	if value:
		color = original_color
	else:
		color = disable_color
	m_collidable = value

func get_collidable():
	return m_collidable

func get_left():
	return global_position.x + x

func get_right():
	return global_position.x + x + width

func get_top():
	return global_position.y + y

func get_bottom():
	return global_position.y + y + height

func _draw():
	draw_rect(Rect2(x, y, width, height), color)

func _physics_process(delta):
	update()

func intersects(other, offset):
	if !self.collidable || !other.collidable:
		return false
	else:
		return ((self.right + offset.x) > other.left && (self.left + offset.x) < other.right
	&& (self.bottom + offset.y) > other.top && (self.top + offset.y) < other.bottom)

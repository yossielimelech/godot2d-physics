extends "res://Scripts/Wall.gd"

var remainder = Vector2.ZERO

func move_x(amount):
	remainder.x += amount;
	var move = round(remainder.x)
	if(move != 0):
		var riders = Game.get_all_riding_actors(self)
		remainder.x -= move
		global_position.x += move
		for actor in Game.get_all_actors():
			if(hitbox.intersects(actor.hitbox, Vector2.ZERO)):
				if(move > 0):
					actor.move_x_exact((hitbox.right - actor.hitbox.left), funcref(actor, "squish"))
				else:
					actor.move_x_exact((hitbox.left - actor.hitbox.right), funcref(actor, "squish"))
			elif (riders.has(actor)):
				actor.move_x_exact(move, null)


func move_y(amount):
	remainder.y += amount
	var move = round(remainder.y)
	if(move != 0):
		var riders = Game.get_all_riding_actors(self)
		remainder.y -= move
		global_position.y += move
		hitbox.collidable = !jump_thru
		for actor in Game.get_all_actors():
			if hitbox.intersects(actor.hitbox, Vector2.ZERO):
				if(move > 0):
					actor.move_y_exact(hitbox.bottom - actor.hitbox.top, funcref(actor, "squish"))
				else:
					actor.move_y_exact(hitbox.top - actor.hitbox.bottom, funcref(actor, "squish"))
			elif riders.has(actor):
				actor.move_y_exact(move, null)
		hitbox.collidable = true

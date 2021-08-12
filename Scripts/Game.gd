extends Node


func check_walls_collision(entity, offset):
	var walls = get_tree().get_nodes_in_group("Walls")
	for wall in walls:
		if wall.jump_thru:
			if offset == Vector2.DOWN && entity.is_riding(wall, offset):
				return true
		elif entity.hitbox.intersects(wall.hitbox, offset):
			return true
	return false

func get_all_actors():
	return get_tree().get_nodes_in_group("Actors")

func get_all_riding_actors(solid):
	var riders : Array
	var actors = get_all_actors()
	for actor in actors:
		if actor.is_riding(solid, Vector2.DOWN):
			riders.append(actor)
	return riders

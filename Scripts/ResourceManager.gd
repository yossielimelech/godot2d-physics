extends Node

var resources = {}

func _ready():
	for resource in get_children():
		resources[resource.resource_name] = resource

func update(resource : String, amount):
	resources[resource].update(amount)

func can_consume(resource, amount):
	return resources[resource].can_consume(amount)

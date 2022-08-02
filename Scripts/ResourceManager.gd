extends Node

var resources = {}

func _ready():
	for resource in get_children():
		resource.connect("on_resource_update", self, "_on_resource_update")
		resource.connect("on_max_resource_update", self, "_on_max_resource_update")
		resources[resource.resource_name] = resource

func update(resource : String, amount):
	resources[resource].update(amount)

func can_consume(resource, amount):
	return resources[resource].can_consume(amount)

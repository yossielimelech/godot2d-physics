extends "res://Scripts/Actor.gd"
class_name Player

signal on_health_update
signal on_max_health_update
signal on_player_die

onready var resource : GameResource = GameResource.new()


onready var resource_manager = $ResourceManager
onready var animated_sprite = $AnimatedSprite
onready var normal_hitbox = $NormalHitbox
onready var hitbox = normal_hitbox
onready var roll_hitbox = $RollHitbox
onready var stateMachine = $PlayerStateMachine
onready var stateLabel = $State
onready var drop_attack_rays_node = $DropAttackRays

var velocity = Vector2.ZERO
var max_run = 100
var run_accel = 600
var run_deccel = 500
var gravity = 1000
var max_fall = 160
var jump_force = -160
var roll_force = 240
var dodge_force = 160
var cayote_time = 0.1
var local_cayote_time = 0
var local_stamina_regen_time = 0
var face : int setget ,get_face

var on_ground : bool
var was_on_ground : bool
var direction : int

var attack_animations = {"Attack1" : 4, "Attack2" : 5}


func _process(delta):
	
	stateLabel.text = stateMachine.State.Name
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	stateMachine.animate(delta)

func _physics_process(delta):
	
	on_ground = Game.check_walls_collision(self, Vector2.DOWN)
	
	if(was_on_ground && !on_ground):
		local_cayote_time = cayote_time
	
	was_on_ground = on_ground
	
	direction = get_direction()
	
	local_cayote_time -= delta
	local_stamina_regen_time -= delta
	
	stateMachine.update(delta)

	if abs(velocity.x) > abs(max_run * direction):
		velocity.x = move_toward(velocity.x, max_run * direction, run_deccel * delta)
	else:
		velocity.x = move_toward(velocity.x, max_run * direction, run_accel * delta)
	
	velocity.y = move_toward(velocity.y, max_fall, gravity * delta)
	
	move_x(velocity.x * delta, funcref(self, "on_collision_x"))
	move_y(velocity.y * delta, funcref(self, "on_collision_y"))

func get_face():
	if animated_sprite.flip_h:
		return -1
	else:
		return 1
	

func AttackAnimationEnded():
	for attack in attack_animations:
		if(animated_sprite.animation == attack && animated_sprite.frame == animated_sprite.frames.get_frame_count(attack) - 1):
			return true
			
func AnimationEnded(animation):
	if(animated_sprite.animation == animation && animated_sprite.frame ==  animated_sprite.frames.get_frame_count(animation) - 1):
		return true

func PlayUniqueAnimation(animation):
	if(animated_sprite.is_playing()  && attack_animations.has(animation) && attack_animations.has(animated_sprite.animation)):
		return
	if(animated_sprite.is_playing() && animated_sprite.animation == animation):
		return
	print("playing animation: %s" % animation)
	animated_sprite.play(animation)
	
func PlayAttackAnimation():
	PlayUniqueAnimation(GetRandomGroundAttack())

func GetRandomGroundAttack():
	var i = randi() % 2 + 1
	return "Attack%s" % i

func on_collision_x():
	velocity.x = 0
	zero_remainder_x()
func on_collision_y():
	velocity.y = 0
	zero_remainder_y()
	
func is_riding(solid, offset):
	return !hitbox.intersects(solid.hitbox, Vector2.ZERO) && hitbox.intersects(solid.hitbox, offset)

func squish():
	print("squished")
	
func get_direction():
	return sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))

func drop_attack_rays_colliding():
	for child in drop_attack_rays_node.get_children():
		if child.is_colliding():
			return true
	return false
	
func consume_resource(resource, amount):
	resource_manager.update(resource, amount)

func can_consume(resource, amount):
	return resource_manager.can_consume(resource, amount)

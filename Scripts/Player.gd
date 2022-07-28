extends "res://Scripts/Actor.gd"
onready var animated_sprite = $AnimatedSprite
onready var hitbox = $Hitbox

var velocity = Vector2.ZERO
var max_run = 100
var run_accel = 600
var run_deccel = 500
var gravity = 1000
var max_fall = 160
var jump_force = -160
var jump_hold_time = 0.2
var local_hold_time = 0
var cayote_time = 0.1
var local_cayote_time = 0

var on_ground : bool
var was_on_ground : bool
var direction : int
var attacking : bool
var air_attack : bool

var attack_animations = {"Attack1" : 4, "Attack2" : 5, "Attack3" : 5 }

func _process(delta):
	on_ground = Game.check_walls_collision(self, Vector2.DOWN)
	
	if(was_on_ground && !on_ground):
		local_cayote_time = cayote_time

	was_on_ground = on_ground
	
	direction = sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))	
	
	CheckIfAttackAnimationEnded()
	
	if !attacking && !air_attack:
		var attack = Input.is_action_just_pressed("Attack")
		if on_ground:
			attacking = attack
		else:
			air_attack = attack
	elif attacking:
		direction = 0
	else:
		air_attack = !on_ground
	

	var jumping = Input.is_action_just_pressed("jump")
	if jumping && (on_ground || local_cayote_time > 0):
		velocity.y = jump_force
		local_hold_time = jump_hold_time
	elif local_hold_time > 0:
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force
		else:
			local_hold_time = 0
	
	local_hold_time -= delta
	local_cayote_time -= delta
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	PlayCorrectAnimation(velocity)

	if abs(velocity.x) > abs(max_run * direction):
		velocity.x = move_toward(velocity.x, max_run * direction, run_deccel * delta)
	else:
		velocity.x = move_toward(velocity.x, max_run * direction, run_accel * delta)
	
	velocity.y = move_toward(velocity.y, max_fall, gravity * delta)
	
	move_x(velocity.x * delta, funcref(self, "on_collision_x"))
	move_y(velocity.y * delta, funcref(self, "on_collision_y"))

func CheckIfAttackAnimationEnded():
	for attack in attack_animations:
		if(animated_sprite.animation == attack && animated_sprite.frame == animated_sprite.frames.get_frame_count(attack) - 1):
			attacking = false
		
	if(animated_sprite.animation == "AirAttack" && animated_sprite.frame ==  animated_sprite.frames.get_frame_count("AirAttack") - 1):
		air_attack = false;

func PlayCorrectAnimation(velocity):
	if air_attack:
		PlayUniqueAnimation("AirAttack")
		return
	if attacking:
		PlayUniqueAnimation(GetRandomGroundAttack())
		return
	if !on_ground:
		if velocity.y < 0:
			PlayUniqueAnimation("Jump")
		else:
			PlayUniqueAnimation("Fall")
	else:
		if direction != 0:
			PlayUniqueAnimation("Run")
		else:
			PlayUniqueAnimation("Idle")

func PlayUniqueAnimation(animation):
	if(animated_sprite.is_playing()  && attack_animations.has(animation) && attack_animations.has(animated_sprite.animation)):
		return
	if(animated_sprite.is_playing() && animated_sprite.animation == animation):
		return
	animated_sprite.play(animation)

func GetRandomGroundAttack():
	var i = randi() % 3 + 1
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
	
	
	

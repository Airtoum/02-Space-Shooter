extends KinematicBody2D

onready var global = get_node("/root/Global")
var Explosion1 = load("res://Entities/Explosion1.tscn")

var velocity = Vector2(0, 0)
var angle = 0
var player = 1
var AI = null

var engines = 0.1
var turn = 0.2
var maxspeed = 6.0
var mass = 1.0
var crew = 20
var maxcrew = 20
var batt = 20
var maxbatt = 20

func fly():
	var collision = move_and_collide(velocity, false, true, false)
	if collision and collision.get_collider().has_method("fly"):
		var colvelocity = collision.get_collider().velocity
		var colmass = collision.get_collider().mass
		var myvelocity = velocity
		# 1 dimensional conservation of momentum and kinetic energy. This assumes that it's always a head-on collision, but it works well enough.
		velocity = (mass - colmass) / (mass + colmass) * myvelocity + (2 * colmass) / (mass + colmass) * colvelocity
		collision.get_collider().velocity = (2 * mass) / (mass + colmass) * myvelocity + (colmass - mass) / (mass + colmass) * colvelocity
		velocity *= 0.9
	position.x = wrapf(position.x, global.wrapminx, global.wrapx)
	position.y = wrapf(position.y, global.wrapminy, global.wrapy)
	return collision

func input(player, key, state):
	if global.twoplayer:
		var playerstr
		if player == 1:
			playerstr = ""
		else:
			playerstr = "2"
		if state == "down":
			return Input.is_action_just_pressed(key + playerstr)
		if state == "held":
			return Input.is_action_pressed(key + playerstr)
		if state == "up":
			return Input.is_action_just_released(key + playerstr)
	elif player == 1:
		if state == "down":
			return Input.is_action_just_pressed(key) or Input.is_action_just_pressed(key + "2")
		if state == "held":
			return Input.is_action_pressed(key) or Input.is_action_pressed(key + "2")
		if state == "up":
			return Input.is_action_just_released(key) or Input.is_action_just_released(key + "2")
	else:
		return AI.get_input(player, key)

func create_explosion(where):
	var explosion = Explosion1.instance()
	explosion.position = where
	get_node("/root/Game/Entities").add_child(explosion)
	explosion.get_node("AnimatedSprite").playing = true

func check_die():
	if crew <= 0:
		for x in range(10):
			create_explosion(position + Vector2(rand_range(-30,30), rand_range(-30,30)))
		queue_free()

extends Node2D


onready var entities = get_node("/root/Game/Entities")
onready var global = get_node("/root/Global")

var right = false
var left = false
var forward = false
var fire = false
var secondary = false
var currenttask = "Idle"
var currenttaskobj = null

var myship
var enemy
var targetangle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	targetangle = rand_range(0, 2 * PI)

func get_input(player, key):
	match key:
		"up":
			return forward
		"left":
			return left
		"right":
			return right
		"fire":
			return fire
		"secondary":
			return secondary
	push_error("Weird expected input")

func set_task(name, obj):
	currenttask = name
	currenttaskobj = obj

func distance(A, B):
	#shoutouts to this website https://blog.demofox.org/2017/10/01/calculating-the-distance-between-points-in-wrap-around-toroidal-space/
	var dists = Vector2(abs(B.x - A.x), abs(B.y - A.y))
	if dists.x > global.wrapx * 0.5:
		dists.x = global.wrapx - dists.x
	if dists.y > global.wrapy * 0.5:
		dists.y = global.wrapy - dists.y
	return sqrt(dists.x * dists.x + dists.y * dists.y)

func trajectory(time, pos, velocity):
	#game runs at about 60 fps, so I'm using a timescale of 40 for about normal reaction times
	var newpos = (pos + velocity * 40 * time)
	var newx = wrapf(newpos.x, global.wrapminx, global.wrapx)
	var newy = wrapf(newpos.y, global.wrapminy, global.wrapy)
	return Vector2(newx, newy)
	
func angle_between(A, B):
	var dists = B - A
	if dists.x > global.wrapx * 0.5:
		dists.x = global.wrapx - dists.x
	if dists.y > global.wrapy * 0.5:
		dists.y = global.wrapy - dists.y
	return dists.angle()
	
func anglediff(a, b):
	var diff = abs(b - a)
	if diff > PI:
		diff = 2 * PI - diff
	return diff

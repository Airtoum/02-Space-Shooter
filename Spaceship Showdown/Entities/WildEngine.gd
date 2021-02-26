extends Area2D

onready var global = get_node("/root/Global")

var velocity = Vector2(0, 0)
var latched = null
var offset = Vector2(0, 0)
var latchangle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Entities")

func rotate_vector2(v, theta):	#the rotation matrix from wikipedia
	return Vector2(v.x * cos(theta) - v.y * sin(theta), v.x * sin(theta) + v.y * cos(theta))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if latched:
		var adjustedoffset = rotate_vector2(offset, latched.angle - latchangle)
		position = latched.position - adjustedoffset
		rotation = adjustedoffset.angle()
		latched.velocity += adjustedoffset.normalized() * 0.2
	else:
		position += velocity
		position.x = wrapf(position.x, global.wrapminx, global.wrapx)
		position.y = wrapf(position.y, global.wrapminy, global.wrapy)


func _on_WildEngine_body_entered(body):
	if body.has_method("fly") and not latched:
		latched = body
		offset = body.position - position
		latchangle = body.angle

func _on_Lifespan_timeout():
	queue_free()

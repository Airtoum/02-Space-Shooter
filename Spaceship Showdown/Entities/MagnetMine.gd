extends Area2D

onready var global = get_node("/root/Global")

var velocity = Vector2(0, 0)
var magnetlist = []
var firedfrom

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Entities")
	for v in range(0,9):
		if v == 4:
			continue
		var copysprite = $AnimatedSprite.duplicate()
		var newpos = Vector2((v/3 - 1) * global.wrapx, (v%3 - 1) * global.wrapy) + Vector2(1, 1)
		copysprite.position = newpos
		add_child(copysprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += velocity
	velocity = velocity * 0.9
	for o in magnetlist:
		var disp = (o.position - position)
		velocity += min(4 / disp.length() , 4) * disp.normalized()
	position.x = wrapf(position.x, global.wrapminx, global.wrapx)
	position.y = wrapf(position.y, global.wrapminy, global.wrapy)

func _on_MagnetField_body_entered(body):
	magnetlist.append(body)


func _on_MagnetField_body_exited(body):
	magnetlist.erase(body)


func _on_MagnetMine_body_entered(body):
	if body != firedfrom:
		if body.has_method("damage"):
			body.damage(3, "metal")
		queue_free()
		


func _on_Lifespan_timeout():
	queue_free()

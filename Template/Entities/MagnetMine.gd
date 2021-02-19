extends Area2D


var velocity = Vector2(0, 0)
var magnetlist = []
var firedfrom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity
	velocity = velocity * 0.9
	for o in magnetlist:
		var disp = (o.position - position)
		velocity += min(4 / disp.length() , 4) * disp.normalized()

func _on_MagnetField_body_entered(body):
	magnetlist.append(body)


func _on_MagnetField_body_exited(body):
	magnetlist.erase(body)


func _on_MagnetMine_body_entered(body):
	if body != firedfrom:
		if body.has_method("damage"):
			body.damage(4, "metal")
		queue_free()


func _on_Lifespan_timeout():
	queue_free()

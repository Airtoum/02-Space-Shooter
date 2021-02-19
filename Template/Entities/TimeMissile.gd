extends "res://Ships/Ship.gd"


var firedfrom

# Called when the node enters the scene tree for the first time.
func _ready():
	mass = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = fly()
	if collision:
		var body = collision.get_collider()
		if body.has_method("damage") and body != firedfrom:
			body.damage(1, "explosion")
		queue_free()

func damage(amount, type):
	if type == "fire":
		queue_free()
	if amount > 2:
		queue_free()


func _on_Lifespan_timeout():
	queue_free()

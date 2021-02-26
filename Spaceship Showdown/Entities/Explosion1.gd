extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Entities")




func _on_AnimatedSprite_animation_finished():
	queue_free()

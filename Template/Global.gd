extends Node

var wrapx = 824
var wrapy = 600

func _process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

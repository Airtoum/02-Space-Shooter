extends Control

onready var global = get_node("/root/Global")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_1Player_pressed():
	global.twoplayer = false
	get_tree().change_scene("res://Menu/ChooseShips.tscn")

func _on_2Player_pressed():
	global.twoplayer = true
	get_tree().change_scene("res://Menu/ChooseShips.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://Menu/Crebits.tscn")


func _on_Quit_pressed():
	get_tree().quit()

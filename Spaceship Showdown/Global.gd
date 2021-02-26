extends Node

var edges = 0
var wrapminx = -edges
var wrapminy = -edges
var wrapx = 824 * 1.5 + edges
var wrapy = 600 * 1.5 + edges
var twoplayer = true
var ship1 = "Reklack"
var ship2 = "Tempotera"

func _ready():
	VisualServer.set_default_clear_color(Color(0,0,0,1))
	randomize()

func _process(_delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

extends Node2D

onready var global = get_node("/root/Global")
onready var Reklack = load("res://Ships/Reklack.tscn")
onready var Tempotera = load("res://Ships/Tempotera.tscn")

var player1
var player2
var deadcounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawn = Vector2(rand_range(0, global.wrapx), rand_range(0, global.wrapy))
	player1 = create_ship(global.ship1, 1, spawn)
	player2 = create_ship(global.ship2, 2, spawn + Vector2(global.wrapx/2, global.wrapy/2))
	player1.setup(player2)
	player2.setup(player1)
	$HUD.setup()

func create_ship(name, player, pos):
	var ship = null
	if name == "Reklack":
		ship = Reklack.instance()
	if name == "Tempotera":
		ship = Tempotera.instance()
	if ship == null:
		push_error("Cannot create ship of type " + str(name) + "! AAAAAA")
	add_child_below_node($Entities, ship)
	ship.player = player
	ship.position = pos
	return ship

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player1 == null or player2 == null:
		deadcounter += 1
	if deadcounter >= 180:
		var wintext = ( str_not_null(player1) + str_not_null(player2) + " WINS!" ).to_upper()
		$HUD/Win.text = wintext
	if deadcounter >= 360:
		get_tree().change_scene("res://Menu/Menu.tscn")

func str_not_null(obj):
	if obj == null:
		return ""
	else:
		return obj.name

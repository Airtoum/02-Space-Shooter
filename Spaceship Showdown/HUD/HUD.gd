extends Control

onready var game = get_node("/root/Game")
onready var global = get_node("/root/Global")

onready var Point = load("res://HUD/Point.tscn")

# Called when the node enters the scene tree for the first time.
func setup():
	var player1 = game.player1
	var player2 = game.player2
	$Player1.texture = get_ship_ui_texture(global.ship1)
	$Player2.texture = get_ship_ui_texture(global.ship2)
	var pointmargin = 3
	var crewanchor = Vector2(53, 200)
	$Player1/Crew.rect_size.y = (player1.maxcrew / 2) * (7 + pointmargin) + pointmargin
	$Player1/Crew.rect_position.y = crewanchor.y - $Player1/Crew.rect_size.y
	for p in range(0, player1.maxcrew):
		var point = Point.instance()
		point.rect_position = $Player1/Crew.rect_size - Vector2(p % 2 * (point.rect_size.x + pointmargin), (p / 2) * (point.rect_size.y + pointmargin) ) + Vector2(-(point.rect_size.x + pointmargin), -10)
		point.color = Color(0, 0.9, 0, 1)
		point.index = p + 1
		point.ship = player1
		point.type = "crew"
		$Player1/Crew.add_child(point)
	var battanchor = Vector2(147, 200)
	$Player1/Batt.rect_size.y = (player1.maxbatt / 2) * (7 + pointmargin) + pointmargin
	$Player1/Batt.rect_position.y = battanchor.y - $Player1/Batt.rect_size.y
	for p in range(0, player1.maxbatt):
		var point = Point.instance()
		point.rect_position = $Player1/Batt.rect_size - Vector2(p % 2 * (point.rect_size.x + pointmargin), (p / 2) * (point.rect_size.y + pointmargin) ) + Vector2(-(point.rect_size.x + pointmargin), -10)
		point.color = Color(0.9, 0, 0, 1)
		point.index = p + 1
		point.ship = player1
		point.type = "batt"
		$Player1/Batt.add_child(point)
	$Player2/Crew.rect_size.y = (player2.maxcrew / 2) * (7 + pointmargin) + pointmargin
	$Player2/Crew.rect_position.y = crewanchor.y - $Player2/Crew.rect_size.y
	for p in range(0, player2.maxcrew):
		var point = Point.instance()
		point.rect_position = $Player2/Crew.rect_size - Vector2(p % 2 * (point.rect_size.x + pointmargin), (p / 2) * (point.rect_size.y + pointmargin) ) + Vector2(-(point.rect_size.x + pointmargin), -10)
		point.color = Color(0, 0.9, 0, 1)
		point.index = p + 1
		point.ship = player2
		point.type = "crew"
		$Player2/Crew.add_child(point)
	$Player2/Batt.rect_size.y = (player2.maxbatt / 2) * (7 + pointmargin) + pointmargin
	$Player2/Batt.rect_position.y = battanchor.y - $Player2/Batt.rect_size.y
	for p in range(0, player2.maxbatt):
		var point = Point.instance()
		point.rect_position = $Player2/Batt.rect_size - Vector2(p % 2 * (point.rect_size.x + pointmargin), (p / 2) * (point.rect_size.y + pointmargin) ) + Vector2(-(point.rect_size.x + pointmargin), -10)
		point.color = Color(0.9, 0, 0, 1)
		point.index = p + 1
		point.ship = player2
		point.type = "batt"
		$Player2/Batt.add_child(point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	$Player1/Crew

func get_ship_ui_texture(name):
	if name == "Reklack":
		return load("res://HUD/UIReklack.png")
	if name == "Tempotera":
		return load("res://HUD/UITempotera.png")

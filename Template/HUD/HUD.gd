extends Control

export onready var player1 = get_node("/root/Game/Reklack")
export onready var player2 = get_node("/root/Game/Tempotera")

onready var Point = load("res://HUD/Point.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
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

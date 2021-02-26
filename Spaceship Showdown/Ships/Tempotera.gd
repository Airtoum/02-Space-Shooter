extends "res://Ships/Ship.gd"

onready var TimeMissile = load("res://Entities/TimeMissile.tscn")
onready var TempoteraEcho = load("res://Entities/TempoteraEcho.tscn")

onready var TempoteraAI = load("res://AI/TempoteraAI.tscn")

var wraparound = []
var primaryready = true
var history = []

# Called when the node enters the scene tree for the first time.
func _ready():
	engines = 0.15
	turn = 0.11
	maxspeed = 7.0
	mass = 0.7
	crew = 20
	maxcrew = 20
	batt = 16
	maxbatt = 16
	player = 2
	# this part creates a grid of copies of the sprite and collision beyond the edges of the screen for wraparound
	for v in range(0,9):										# copy copy copy
		if v == 4:												# copy orig copy
			wraparound.append([$Sprite,$CollisionPolygon2D])	# copy copy copy
			continue
		var copysprite = $Sprite.duplicate()
		var copycoll = $CollisionPolygon2D.duplicate()
		var newpos = Vector2((v/3 - 1) * global.wrapx, (v%3 - 1) * global.wrapy) + Vector2(1, 1)
		copysprite.position = newpos
		copycoll.position = newpos
		add_child(copysprite)
		add_child(copycoll)
		wraparound.append([copysprite, copycoll])

func setup(enemy):
	if not global.twoplayer and player == 2:
		AI = TempoteraAI.instance()
		AI.myship = self
		AI.enemy = enemy
		add_child(AI)

func _physics_process(_delta):
	history.push_front([position, velocity, angle, crew])
	while history.size() > 60:
		history.pop_back()
	if input(player, "up", "held"):
		velocity += engines * Vector2(cos(angle), sin(angle))
		if velocity.length() > maxspeed:
			velocity = lerp(velocity, velocity.normalized() * maxspeed, -1 / (engines + 1) + 1)
	if input(player, "left", "held"):
		angle -= turn
	if input(player, "right", "held"):
		angle += turn
	if input(player, "fire", "down") and primaryready and batt >= 3:
		var timemissile = TimeMissile.instance()
		timemissile.position = position + Vector2(cos(angle), sin(angle)) * 70.0 + velocity
		velocity += Vector2(cos(angle), sin(angle)) * -0.4
		timemissile.velocity = Vector2(cos(angle), sin(angle)) * 10.0
		timemissile.angle = angle + PI/2
		timemissile.firedfrom = self
		get_node("/root/Game/Entities").add_child(timemissile)
		primaryready = false
		$TimeMissileCooldown.start()
		batt -= 3
	if input(player, "secondary", "down") and batt >= 14:
		var revert = history[-1]
		position = revert[0]
		velocity = revert[1]
		angle = revert[2]
		crew = revert[3]
		batt = 0
		for f in range(0,history.size()):
			var echo = TempoteraEcho.instance()
			echo.position = history[f][0]
			echo.rotation = history[f][2]
			echo.lifespan = f
			get_node("/root/Game/Entities").add_child(echo)
	fly()
	for n in wraparound:
		n[0].rotation = angle + PI/2
		n[1].rotation = angle + PI/2
	check_die()

func damage(amount, type):
	crew -= amount


func _on_TimeMissileCooldown_timeout():
	primaryready = true


func _on_PowerCore_timeout():
	batt += 1
	batt = min(batt, maxbatt)

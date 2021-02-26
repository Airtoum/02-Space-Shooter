extends "res://Ships/Ship.gd"

onready var MagnetMine = load("res://Entities/MagnetMine.tscn")
onready var WildEngine = load("res://Entities/WildEngine.tscn")

onready var ReklackAI = load("res://AI/ReklackAI.tscn")

var wraparound = []
var primaryready = true
var secondaryready = true

# Called when the node enters the scene tree for the first time. Happens when it's instanced!
func _ready():
	engines = 0.1
	turn = 0.1
	maxspeed = 6.0
	mass = 1.0
	crew = 22
	maxcrew = 22
	batt = 20
	maxbatt = 20
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
		AI = ReklackAI.instance()
		AI.myship = self
		AI.enemy = enemy
		add_child(AI)

func _physics_process(_delta):
	if input(player, "up", "held"):
		velocity += engines * Vector2(cos(angle), sin(angle))
		if velocity.length() > maxspeed:
			velocity = lerp(velocity, velocity.normalized() * maxspeed, -1 / (engines + 1) + 1)
	if input(player, "left", "held"):
		angle -= turn
	if input(player, "right", "held"):
		angle += turn
	fly()
	if input(player, "fire", "down") and primaryready and batt >= 7:
		var magnetmine = MagnetMine.instance()
		magnetmine.position = position
		magnetmine.velocity = velocity + Vector2(cos(angle), sin(angle)) * 18.0
		magnetmine.firedfrom = self
		get_node("/root/Game/Entities").add_child(magnetmine)
		primaryready = false	
		$MagnetMineCooldown.start()
		batt -= 7
	if input(player, "secondary", "down") and secondaryready and batt >= 3:
		var wildengine = WildEngine.instance()
		wildengine.position = position + Vector2(cos(angle), sin(angle)) * 70
		wildengine.velocity = velocity + Vector2(cos(angle), sin(angle)) * 18.0
		wildengine.rotation = angle
		get_node("/root/Game/Entities").add_child(wildengine)
		secondaryready = false
		$WildEngineCooldown.start()
		batt -= 3
	for n in wraparound:
		n[0].rotation = angle + PI/2
		n[1].rotation = angle + PI/2
	check_die()

func damage(amount, type):
	crew -= amount

func _on_MagnetMineCooldown_timeout():
	primaryready = true


func _on_PowerCore_timeout():
	batt += 1
	batt = min(batt, maxbatt)


func _on_WildEngineCooldown_timeout():
	secondaryready = true

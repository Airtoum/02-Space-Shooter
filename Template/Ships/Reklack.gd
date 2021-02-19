extends "res://Ships/Ship.gd"

onready var MagnetMine = load("res://Entities/Magnetmine.tscn")

var primaryready = true

# Called when the node enters the scene tree for the first time.
func _ready():
	engines = 0.1
	turn = 0.1
	maxspeed = 6.0
	mass = 1.0
	crew = 22
	maxcrew = 22
	batt = 20
	maxbatt = 20

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		velocity += engines * Vector2(cos(rotation), sin(rotation))
		if velocity.length() > maxspeed:
			velocity = lerp(velocity, velocity.normalized() * maxspeed, -1 / (engines + 1) + 1)
	if Input.is_action_pressed("left"):
		rotation -= turn
	if Input.is_action_pressed("right"):
		rotation += turn
	fly()
	if Input.is_action_just_pressed("fire") and primaryready and batt >= 12:
		var magnetmine = MagnetMine.instance()
		magnetmine.position = position
		magnetmine.velocity = velocity + Vector2(cos(rotation), sin(rotation)) * 18.0
		magnetmine.firedfrom = self
		get_node("/root/Game/Entities").add_child(magnetmine)
		primaryready = false
		$MagnetMineCooldown.start()
		batt -= 12

func damage(amount, type):
	crew -= amount

func _on_MagnetMineCooldown_timeout():
	primaryready = true


func _on_PowerCore_timeout():
	batt += 1
	batt = min(batt, maxbatt)

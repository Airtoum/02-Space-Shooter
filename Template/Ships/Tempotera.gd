extends "res://Ships/Ship.gd"

onready var TimeMissile = load("res://Entities/TimeMissile.tscn")

var primaryready = true

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

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		velocity += engines * Vector2(cos(rotation), sin(rotation))
		if velocity.length() > maxspeed:
			velocity = lerp(velocity, velocity.normalized() * maxspeed, -1 / (engines + 1) + 1)
	if Input.is_action_pressed("left"):
		rotation -= turn
	if Input.is_action_pressed("right"):
		rotation += turn
	if Input.is_action_pressed("fire") and primaryready and batt >= 4:
		var timemissile = TimeMissile.instance()
		timemissile.position = position + Vector2(cos(rotation), sin(rotation)) * 70.0 + velocity
		velocity += Vector2(cos(rotation), sin(rotation)) * -0.4
		timemissile.velocity = Vector2(cos(rotation), sin(rotation)) * 10.0
		timemissile.rotation = rotation + PI/2
		timemissile.firedfrom = self
		get_node("/root/Game/Entities").add_child(timemissile)
		primaryready = false
		$TimeMissileCooldown.start()
		batt -= 4
	fly()

func damage(amount, type):
	crew -= amount


func _on_TimeMissileCooldown_timeout():
	primaryready = true


func _on_PowerCore_timeout():
	batt += 1
	batt = min(batt, maxbatt)

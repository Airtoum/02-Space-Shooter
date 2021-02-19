extends KinematicBody2D

var velocity = Vector2(0, 0)
var omega = 0

var engines = 0.1
var turn = 0.2
var maxspeed = 6.0
var mass = 1.0
var crew = 20
var maxcrew = 20
var batt = 20
var maxbatt = 20

func fly():
	var collision = move_and_collide(velocity, false, true, false)
	if collision and collision.get_collider().has_method("fly"):
		var colvelocity = collision.get_collider().velocity
		var colmass = collision.get_collider().mass
		var myvelocity = velocity
		velocity = (mass - colmass) / (mass + colmass) * myvelocity + (2 * colmass) / (mass + colmass) * colvelocity
		collision.get_collider().velocity = (2 * mass) / (mass + colmass) * myvelocity + (colmass - mass) / (mass + colmass) * colvelocity
		velocity *= 0.9
	position.x = fposmod(position.x, get_viewport_rect().size.x)
	position.y = fposmod(position.y, get_viewport_rect().size.y)
	return collision

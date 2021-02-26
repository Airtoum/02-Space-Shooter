extends "res://AI/AI.gd"


var MagnetMine = load("res://Entities/MagnetMine.gd")
var framesidle = 0
var lastcrew = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = myship.position
	var vel = myship.velocity
	var angle = myship.angle
	var batt = myship.batt
	var crew = myship.crew
	#print(currenttask + " " + str(currenttaskobj))
	forward = false
	left = false
	right = false
	fire = false
	secondary = false
	if crew < lastcrew:
		secondary = true
	match currenttask:
		"Idle":
			framesidle += 1
			var stop = scan_for_avoid(pos, vel)
			if not stop:
				if framesidle > 60 and distance(pos, enemy.position) > 500:
					set_task("Approach", enemy)
				elif distance(pos, enemy.position) < 300:
					set_task("Attack" , enemy)
		"Avoid":
			framesidle = 0
			if currenttaskobj == null or (distance(trajectory(2, pos, vel), currenttaskobj.position) > 300 and distance(trajectory(4, pos, vel), currenttaskobj.position) > 200):
				set_task("Idle", null)
			else:
				#this doesn't factor in screen wrap but oh well
				var anglediff = angle - (currenttaskobj.position - pos).angle()
				if abs(anglediff) < 2 * PI/3:
					if anglediff < 0:
						right = true
					else:
						left = true
					if abs(anglediff) > PI/3:
						forward = true
				else:
					forward = true
		"Approach":
			framesidle = 0
			if currenttaskobj == null or distance(pos, currenttaskobj.position) < 240:
				set_task("Idle", null)
			else:
				scan_for_avoid(pos, vel)
				var anglediff = anglediff(angle, angle_between(trajectory(0.4, pos, vel), currenttaskobj.position))
				#var anglediff = angle_between(enemy.position, pos) - angle
				if abs(anglediff) > PI/7:
					if anglediff < 0:
						right = true
					else:
						left = true
				forward = true
		"Attack":
			framesidle = 0
			if currenttaskobj == null or batt < 7 or distance(pos, currenttaskobj.position) > 300:
				set_task("Idle", null)
			else:
				var anglediff = anglediff(angle, angle_between(trajectory(0.4, pos, vel), currenttaskobj.position))
				#var anglediff = anglediff(targetangle, angle)
				#var anglediff = angle_between(enemy.position, pos) - angle
				if abs(anglediff) > PI/4:
					if anglediff < 0:
						right = true
					else:
						left = true
				else:
					fire = true
	if currenttaskobj != null:
		$Cursor.global_position = currenttaskobj.position
		#$Cursor.visible = true
	else:
		$Cursor.visible = false
	lastcrew = crew

func scan_for_avoid(pos, vel):
	for i in range(0, entities.get_child_count()):
				var ent = entities.get_child(i)
				if ent is MagnetMine:
					if distance(trajectory(2, pos, vel), ent.position) < 200:
						set_task("Avoid", ent)
						return true
					if distance(trajectory(1, pos, vel), ent.position) < 200:
						set_task("Avoid", ent)
						return true


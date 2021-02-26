extends ColorRect


var index = 0
var ship
var type = "crew"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ship == null:
		visible = false
		return
	if type == "crew":
		visible = ship.crew >= index
	else:
		visible = ship.batt >= index

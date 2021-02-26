extends Control


onready var playertwoimg = load("res://Menu/ChooseShipsPlayer2.png")

onready var global = get_node("/root/Global")

onready var p1reklack = get_node("Player1/ButtonContainer/Player1Reklack")
onready var p1tempotera = get_node("Player1/ButtonContainer/Player1Tempotera")
onready var p2reklack = get_node("Player2/ButtonContainer/Player2Reklack")
onready var p2tempotera = get_node("Player2/ButtonContainer/Player2Tempotera")
onready var textbox = get_node("TextBox")
onready var player2texturerect = get_node("Player2")

var reklacktext = "REKLACK\n\nTHE REKLACK ARE VERY EFFECTIVE AT GETTING THINGS DONE, BUT THAT OFTEN INVOLVES DOING IT UNSAFELY.\n\nPRIMARY WEAPON:\nTHE MAGNET MINE PROPELS FORWARD A BIT AND LINGERS FOR A WHILE. IT WILL DRIFT TOWARDS NEARBY SHIPS. IT DEALS A LOT OF DAMAGE.\n\nSECONDARY WEAPON:\nTHE WILD ENGINE FLIES FORWARDS UNTIL IT LATCHES ONTO A SHIP, MAKING IT SIGNIFICANTLY HARDER TO CONTROL."
var tempoteratext = "TEMPOTERA\n\nTHE TEMPOTERA ARE AN INSECT-LIKE RACE THAT HAVE LONG SINCE UNLOCKED THE SECRET OF TIME TRAVEL.\n\nPRIMARY WEAPON:\nTHE TEMPORAL MISSILE IS SHORT RANGED AND FAST, AND SENDS A CHUNK OF WHATEVER IT HITS 3400 YEARS INTO THE FUTURE.\n\nSECONDARY WEAPON:\nTHE OMEGA ONE RESTORES THE SHIP TO HOW IT WAS 1 SECOND AGO, BRINGING BACK ANYONE WHO DIED AT THE EXPENSE OF THE ENTIRE BATTERY."

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox.text = reklacktext
	if global.twoplayer:
		player2texturerect.texture = playertwoimg

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player1Reklack_pressed():
	p1reklack.disabled = true
	p1tempotera.disabled = false
	textbox.text = reklacktext
	global.ship1 = "Reklack"

func _on_Player1Tempotera_pressed():
	p1tempotera.disabled = true
	p1reklack.disabled = false
	textbox.text = tempoteratext
	global.ship1 = "Tempotera"

func _on_Player2Reklack_pressed():
	p2reklack.disabled = true
	p2tempotera.disabled = false
	textbox.text = reklacktext
	global.ship2 = "Reklack"

func _on_Player2Tempotera_pressed():
	p2tempotera.disabled = true
	p2reklack.disabled = false
	textbox.text = tempoteratext
	global.ship2 = "Tempotera"


func _on_Back_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Go_pressed():
	get_tree().change_scene("res://Game.tscn")

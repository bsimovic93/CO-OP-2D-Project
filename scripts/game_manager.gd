extends Node

var connected_players = {}
var current_scene;


# Called when the node enters the scene tree for the first time.
func _ready():
	print('Test')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func handle_player_hit(player_id):
	print('game over:')
	

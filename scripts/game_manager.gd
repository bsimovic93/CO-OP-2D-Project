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
	var main = get_tree().get_root().get_node('Main');
	#FIXME: we may not need this
	#read doc on remove child vs queue free
	for child in main.get_children():
		child.queue_free()
	main.queue_free()
	get_tree().get_root().call_deferred('remove_child',main)
	
	var level = load("res://scenes/main.tscn").instantiate();
	
	get_tree().get_root().call_deferred('add_child', level)
	

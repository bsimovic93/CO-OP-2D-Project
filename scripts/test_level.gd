extends Node2D

@export var player_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var index =0
	for i in GameManager.connected_players:
		var current_player = player_scene.instantiate()
		current_player.name = str(GameManager.connected_players[i].id)
		current_player.hit.connect(GameManager.handle_player_hit);
		call_deferred('add_child',current_player)
		for spawn in get_tree().get_nodes_in_group('PlayerSpawnPoint'):
			if spawn.name == str(index):
				current_player.global_position = spawn.global_position
		index += 1
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Interaction1.text = str(InteractionManager.interacting_items.keys())


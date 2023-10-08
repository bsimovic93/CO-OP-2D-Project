extends Node2D

@export var player_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var index =0
	for i in GameManager.connected_players:
		var current_player = player_scene.instantiate()
		current_player.name = str(GameManager.connected_players[i].id)
		add_child(current_player)
		for spawn in get_tree().get_nodes_in_group('PlayerSpawnPoint'):
			if spawn.name == str(index):
				current_player.global_position = spawn.global_position
		index += 1
	
	InteractionManager.interaction_happened.connect(_handle_interaction);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if InteractionManager.currently_interacting_object:
		$DebugText.text = str(InteractionManager.currently_interacting_object.name)
	else:
		$DebugText.text = ''
	if Input.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/test_level.tscn");
	pass

@rpc("any_peer","call_local")
func do_interaction(interaction):
	
	if interaction.action == 'lever-pull':
		InteractionManager.currently_interacting_object.is_active = !InteractionManager.currently_interacting_object.is_active
		InteractionManager.currently_interacting_object.interact()
	if interaction.action == 'button-push':
		InteractionManager.currently_interacting_object.is_pushed = true;
	if interaction.action == 'button-relese':
		InteractionManager.currently_interacting_object.is_pushed = false;

func _handle_interaction(interaction):
	do_interaction.rpc(interaction)
	pass


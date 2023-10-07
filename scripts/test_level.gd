extends Node2D

var pressed = load("res://sprites/Sprite-Button-Pressed-Alt.png") 
var unpressed = load("res://sprites/Sprite-Button-Pressed.png")

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
	if Input.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/test_level.tscn");
	pass

@rpc("any_peer","call_local")
func do_interaction(interaction):
	
	if interaction.action == 'lever-pull':
		
		if interaction.value == true:
			InteractionManager.currently_interacting_object.moving_platform.get_node("AnimationPlayer").play("move_up")
			InteractionManager.currently_interacting_object.get_node("AnimatedSprite2D").play("pull_lever");
		else: 
			InteractionManager.currently_interacting_object.moving_platform.get_node("AnimationPlayer").play_backwards("move_up");
			InteractionManager.currently_interacting_object.get_node("AnimatedSprite2D").play_backwards("pull_lever");
	if interaction.action == 'button_push':
		if InteractionManager.currently_interacting_object != null:
			if interaction.value == true:
				InteractionManager.currently_interacting_object.get_node("Sprite2D").set_texture(pressed);
				get_node('Shocker/AnimatedSprite2D').hide();
			else:
				InteractionManager.currently_interacting_object.get_node("Sprite2D").set_texture(unpressed);
				get_node('Shocker/AnimatedSprite2D').show();

func _handle_interaction(interaction):
	# check for iteraction action, if we have multiple diferent types of actions
	# strong binded interactions for now 
	# LEVER -> PLATFORM
	# BUTTON -> DANGER BEAM

	do_interaction.rpc(interaction)
	pass


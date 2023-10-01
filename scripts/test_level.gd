extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	InteractionManager.interaction_happened.connect(_handle_interaction);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://scenes/test_level.tscn");
	pass

func _handle_interaction(interaction):
	
	# check for iteraction action, if we have multiple diferent types of actions
	if interaction.value == true:
		get_node("MovingPlatform/AnimationPlayer").play("move_up")
		get_node("Lever/AnimatedSprite2D").play("pull_lever");
	else: 
		get_node("MovingPlatform/AnimationPlayer").play_backwards("move_up");
		get_node("Lever/AnimatedSprite2D").play_backwards("pull_lever");
	print(interaction)
	pass


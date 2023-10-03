extends Node2D

var pressed = load("res://sprites/Sprite-Button-Pressed-Alt.png") 
var unpressed = load("res://sprites/Sprite-Button-Pressed.png")
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
	# strong binded interactions for now 
	# LEVER -> PLATFORM
	# BUTTON -> DANGER BEAM
	
	if interaction.action == 'lever-pull':
		if interaction.value == true:
			interaction.object.moving_platform.get_node("AnimationPlayer").play("move_up")
			interaction.object.get_node("AnimatedSprite2D").play("pull_lever");
		else: 
			interaction.object.moving_platform.get_node("AnimationPlayer").play_backwards("move_up");
			interaction.object.get_node("AnimatedSprite2D").play_backwards("pull_lever");
	if interaction.action == 'button_push':
		if interaction.value == true:
			interaction.object.get_node("Sprite2D").set_texture(pressed);
			get_node('Shocker/AnimatedSprite2D').hide();
		else:
			interaction.object.get_node("Sprite2D").set_texture(unpressed);
			get_node('Shocker/AnimatedSprite2D').show();
	pass


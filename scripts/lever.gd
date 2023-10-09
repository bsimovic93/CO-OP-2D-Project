extends Node2D
class_name Lever
var current_interacting_body = null;

@export var moving_platform: Node2D;
@export var lever_id = 0;

@export var is_active = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_node("Area2D").get_overlapping_bodies().filter(func(body): return !body.is_in_group('TilemapGroup'))
	if bodies.size() > 0:
		# add this to the stuff
		InteractionManager.add_interacting_item(lever_id, get_node('.'))
		if check_overlap_authority(bodies):
			if Input.is_action_just_pressed("interact"):
				InteractionManager.check_interaction({
					'action': 'lever-pull',
					'id': lever_id
				})
	else:
		InteractionManager.remove_interacting_item(lever_id)
	pass

func check_overlap_authority(bodies: Array[Node2D]):
	var can_interact = false;
	for body in bodies:
		if body.get_node('MultiplayerSynchronizer').get_multiplayer_authority() == multiplayer.get_unique_id():
			can_interact = true
	return can_interact

	

func interact():
	if is_active == true:
		moving_platform.get_node("AnimationPlayer").play("move_up")
		get_node("AnimatedSprite2D").play("pull_lever");
	else: 
		moving_platform.get_node("AnimationPlayer").play_backwards("move_up");
		get_node("AnimatedSprite2D").play_backwards("pull_lever");
	pass


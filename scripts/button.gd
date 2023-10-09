extends Node2D
class_name PushButton
@export var is_pushed = false;
@export var button_id = 0
@export var lightnig_gate: Node2D;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	
	if get_node("Area2D").get_overlapping_bodies().size() > 0:
		# add this to the stuff
		InteractionManager.add_interacting_item(button_id, get_node('.'))
		if check_overlap_authority(get_node("Area2D").get_overlapping_bodies()):
			if Input.is_action_just_pressed("interact") and is_pushed != true:
				InteractionManager.check_interaction({
					'action': 'button-push',
					'id': button_id
				})
			if Input.is_action_just_released("interact"):
				InteractionManager.check_interaction({
					'action': 'button-relese',
					'id': button_id
				})
	else:
		InteractionManager.remove_interacting_item(button_id)
	pass
	
	get_node('AnimatedSprite2D').set_frame(int(is_pushed))
	if is_pushed == true:
		lightnig_gate.hide()
	else:
		lightnig_gate.show()
	
	pass


func check_overlap_authority(bodies: Array[Node2D]):
	var can_interact = false;
	for body in bodies:
		if body.get_node('MultiplayerSynchronizer').get_multiplayer_authority() == multiplayer.get_unique_id():
			can_interact = true
	return can_interact

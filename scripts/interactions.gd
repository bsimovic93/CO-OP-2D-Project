extends Node

#this may have to be an array of objects cuz of multiplayer
@export var currently_interacting_object: Node2D;
@export var can_move: bool = true;
signal  interaction_happened(value);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Here we can lisen when current inter object is not null and 
	# listen for some input to dispatch some events
	if currently_interacting_object != null:
		can_move = true;
		match currently_interacting_object.name:
			'Lever':
				if Input.is_action_just_pressed("interact"):
					can_move = false;
					interaction_happened.emit({
						"action": 'lever-pull'
					});
					print('interaction called')
			'Button':
				if Input.is_action_just_pressed("interact"):
					can_move = false;
					interaction_happened.emit({
						"action": 'button-push'
					});
				if Input.is_action_just_released("interact"):
					interaction_happened.emit({
						"action": 'button-relese'
					});
	pass

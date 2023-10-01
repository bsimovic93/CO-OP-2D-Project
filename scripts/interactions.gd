extends Node

@export var currently_interacting_object: Node2D;
signal  interaction_happened(value: String);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Here we can lisen when current inter object is not null and 
	# listen for some input to dispatch some events
	if currently_interacting_object != null:
		if Input.is_action_just_pressed("interact"):
			currently_interacting_object.is_active = !currently_interacting_object.is_active;
			interaction_happened.emit({
				"action": 'lever-pull',
				"value": currently_interacting_object.is_active
			});
			print('Lever pressed');
	pass

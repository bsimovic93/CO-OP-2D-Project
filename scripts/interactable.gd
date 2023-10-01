extends Node2D
class_name Interactable
var current_interacting_body = null;

var is_active = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_interacting_body != null:
		InteractionManager.currently_interacting_object = get_node(".");
	else:
		InteractionManager.currently_interacting_object = null;
	pass


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		current_interacting_body = body;
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		current_interacting_body = null;
		pass # Replace with function body

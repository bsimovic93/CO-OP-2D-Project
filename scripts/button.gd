extends Node2D
@export var is_pushed = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered_button(body):
	print('e?')
	if body is CharacterBody2D:
		InteractionManager.currently_interacting_object = get_node(".")
		pass # Replace with function body.


func _on_area_2d_body_exited_button(body):
	print('a?')
	if body is CharacterBody2D:
		InteractionManager.currently_interacting_object = null;
		pass # Replace with function body

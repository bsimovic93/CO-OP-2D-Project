extends AnimatableBody2D

enum PlatformDirection  {LEFT, RIGHT, UP, DOWN}

@export var platform_direction: PlatformDirection
@export var travel_distance: int
@onready var animation_player = $AnimationPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	var track = animation_player.get_animation('move_up').find_track('.:position', 0);
	var end_position_x = global_position.x;
	var end_position_y = global_position.y;
	match platform_direction:
		PlatformDirection.LEFT: 
			end_position_x -= travel_distance
		PlatformDirection.RIGHT:
			end_position_x += travel_distance
		PlatformDirection.UP:
			end_position_y -= travel_distance;
		PlatformDirection.DOWN:
			end_position_y += travel_distance;
	animation_player.get_animation('move_up').track_set_key_value(track, 0, Vector2(global_position.x, global_position.y))
	animation_player.get_animation('move_up').track_set_key_value(track, 1, Vector2(end_position_x, end_position_y))
	print(track)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

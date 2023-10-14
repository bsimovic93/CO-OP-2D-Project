extends Node2D


signal level_end(value: bool);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_node("Area2D").get_overlapping_bodies().filter(func(body): return !body.is_in_group('TilemapGroup'))
	if(bodies.size() == 2):
		print('LEVEL END')
		level_end.emit(true)
	pass
